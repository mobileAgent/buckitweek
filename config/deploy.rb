# This defines a deployment "recipe" that you can feed to capistrano
# (http://manuals.rubyonrails.com/read/book/17). It allows you to automate
# (among other things) the deployment of your application.

# =============================================================================
# REQUIRED VARIABLES
# =============================================================================
# You must always specify the application and repository for every recipe. The
# repository must be the URL of the repository you want this recipe to
# correspond to. The deploy_to path must be the path on each machine that will
# form the root of the application path.

set :application, "buckitweek"
set :repository, "http://flester.dyndns.org/repos/#{application}/trunk"
set :server_name, "buckitweek.org"

# =============================================================================
# ROLES
# =============================================================================
# You can define any number of roles, each of which contains any number of
# machines. Roles might include such things as :web, or :app, or :db, defining
# what the purpose of each machine is. You can also specify options that can
# be used to single out a specific subset of boxes in a particular role, like
# :primary => true.

role :web, "#{server_name}"
role :app, "#{server_name}"
role :db,  "#{server_name}", :primary => true

# =============================================================================
# OPTIONAL VARIABLES
# =============================================================================
set :deploy_to, "/var/apps/#{application}"
set :user, "buckitftp"         # defaults to the currently logged in user
set :group, "psacln"

set :svn_username, "mike"
set :db_username, "bwpro"

# Make svn to an export rather than checkout
set :checkout, "export"

# How much to keep on a cleanup task
set :keep_releases, 3

# Web server
set :web_server, "apache2"
set :path_to_web_server, "/usr/local/apache2/"
set :web_server_port, 80

# The Plesk friendly way...
set :user_http_conf, "/home/httpd/vhosts/#{server_name}/conf"


# Mongrel
set "mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"
set :mongrel_prefix, "/usr/local/bin"
set :mongrel_start_port, 3300
set :mongrel_servers, 3

# mongrel has some replacements for restart and spinner:
require 'mongrel_cluster/recipes'

# =============================================================================
# SSH OPTIONS
# =============================================================================
# ssh_options[:keys] = %w(/path/to/my/key /path/to/another/key)
# ssh_options[:port] = 25

# =============================================================================
# TASKS
# =============================================================================
# Define tasks that run on all (or only some) of the machines. You can specify
# a role (or set of roles) that each task should be executed on. You can also
# narrow the set of servers to a subset of a role by specifying options, which
# must match the options given for the servers to select (like :primary => true)



desc "Tasks before initial setup"
task :before_setup do
  sudo "mkdir -p /var/apps"
  sudo "chown -R #{user}:#{group} /var/apps/"
  sudo "mkdir -p /etc/mongrel_cluster"
  sudo "mkdir -p #{path_to_web_server}conf/rails"
  sudo "mkdir -p /var/log/#{application}"
end

desc "Set up mongrel cluster configuration"
task :mongrel_configuration_setup do
  # generate a mongrel_configuration file
  mongrel_configuration = render :template => <<-EOF
---
cwd: #{deploy_to}/current
port: "#{mongrel_start_port}"
environment: production
address: 127.0.0.1
pid_file: #{deploy_to}/current/log/mongrel.pid
log_file: #{deploy_to}/current/log/mongrel.log
servers: #{mongrel_servers}
prefix: #{mongrel_prefix}

EOF

  put mongrel_configuration, "#{deploy_to}/#{shared_dir}/config/mongrel_cluster.yml"
  sudo "ln -nfs #{deploy_to}/#{shared_dir}/config/mongrel_cluster.yml /etc/mongrel_cluster/#{application}.yml"
  
end

desc "After updating the code populate a new database.yml"
task :after_update_code, :roles => :app do
  require "yaml"
  set :production_db_password, proc {Capistrano::CLI.password_prompt("Production db remote password:");}
  buffer = YAML::load_file('config/database.example.yml');
  # purge unneeded configurations
  buffer.delete('test');
  buffer.delete('development');
  
  # Stuff the production, all expected to be there except password
  buffer['production']['password'] = production_db_password

  put YAML::dump(buffer),"#{release_path}/config/database.yml",:mode=>0644

  # Clean up tmp and relink to shared for session and cache data
  sudo "rm -rf #{release_path}/tmp" # because it should not be in svn
  run "ln -nfs #{deploy_to}/#{shared_dir}/tmp #{release_path}/tmp"
end

desc "Setup apache configuration"
task :apache_configuration_setup do
  # generate a webserver configuration
  apache2_rails_conf = <<-EOF
  <VirtualHost #{server_name}:#{web_server_port}>
    Include #{user_http_conf}/#{application}.common
    ErrorLog #{path_to_web_server}/logs/#{application}_errors_log
    CustomLog #{path_to_web_server}logs/#{application}_log combined
  </VirtualHost>
  <Proxy balancer://#{application}_mongrel_cluster>
EOF

  # Builds the mongrel cluster balancer
  (0..mongrel_servers-1).each{ |server|
     apache2_rails_conf += "     BalancerMember http://127.0.0.1:#{mongrel_start_port + server}\n"
  }
  apache2_rails_conf += <<-EOF
  </Proxy>

   Listen #{mongrel_start_port + 81}
   <VirtualHost #{server_name}:#{mongrel_start_port+81}>
      <Location />
         SetHandler balancer-manager
         Deny from all
         Allow from localhost
      </Location>
   </VirtualHost>
EOF
   
  apache2_rails_configuration = render :template => apache2_rails_conf
  
  apache2_rails_common = render :template => <<-EOF

  ServerName #{server_name}
  ServerAlias www.#{server_name}
  UseCanonicalName Off
  DocumentRoot #{deploy_to}/current/public
  <Directory "#{deploy_to}/current/public">
      Options FollowSymLinks
      AllowOverride None
      Order allow,deny
      Allow from all
  </Directory>

  RewriteEngine On

  # Uncomment for rewrite debugging
  #RewriteLog logs/#{application}_rewrite_log
  #RewriteLogLevel 9

  # Check for maintenance file and redirect all requests to it
  RewriteCond %{DOCUMENT_ROOT}/system/maintenance.html -f
  RewriteCond %{SCRIPT_FILENAME} !maintenance.html
  RewriteRule ^.*$ /system/maintenance.html [L]

  #Rewrite index to check for static
  RewriteRule ^/$ /index.html [QSA]
  
  # Redirect all non-static requests to mongrel cluster
  RewriteCond %{DOCUMENT_ROOT}/%{REQUEST_FILENAME} !-f
  RewriteCond %{DOCUMENT_ROOT}/%{REQUEST_FILENAME}.html !-f
  RewriteRule ^/(.*)$ balancer://#{application}_mongrel_cluster%{REQUEST_URI} [P,QSA,L]
EOF

  put apache2_rails_configuration, "#{deploy_to}/#{shared_dir}/system/#{application}.conf"
  put apache2_rails_common, "#{deploy_to}/#{shared_dir}/system/#{application}.common"
  
  sudo "ln -nfs #{deploy_to}/#{shared_dir}/system/#{application}.conf #{user_http_conf}/httpd.include"
  sudo "ln -nfs #{deploy_to}/#{shared_dir}/system/#{application}.common #{user_http_conf}/#{application}.common"
end

desc "Tasks to execute after initial setup"
task :after_setup do
  # Make shared config dir to hold config files
  run "mkdir -p #{deploy_to}/#{shared_dir}/config"
  # Make shared tmp for sessions
  run "mkdir -p #{deploy_to}/#{shared_dir}/tmp"
  run "mkdir -p #{deploy_to}/#{shared_dir}/tmp/sessions"
  run "mkdir -p #{deploy_to}/#{shared_dir}/tmp/cache"
  run "mkdir -p #{deploy_to}/#{shared_dir}/tmp/sockets"

  mongrel_configuration_setup
  # database_configuration_setup
  apache_configuration_setup
  # crontab_configuration_setup
end

desc <<DESC
An imaginary backup task. (Execute the 'show_tasks' task to display all
available tasks.)
DESC
task :backup, :roles => :db, :only => { :primary => true } do
  # the on_rollback handler is only executed if this task is executed within
  # a transaction (see below), AND it or a subsequent task fails.
  on_rollback { delete "/tmp/dump.sql" }

  run "mysqldump -u theuser -p thedatabase > /tmp/dump.sql" do |ch, stream, out|
    ch.send_data "thepassword\n" if out =~ /^Enter password:/
  end
end

# Tasks may take advantage of several different helper methods to interact
# with the remote server(s). These are:
#
# * run(command, options={}, &block): execute the given command on all servers
#   associated with the current task, in parallel. The block, if given, should
#   accept three parameters: the communication channel, a symbol identifying the
#   type of stream (:err or :out), and the data. The block is invoked for all
#   output from the command, allowing you to inspect output and act
#   accordingly.
# * sudo(command, options={}, &block): same as run, but it executes the command
#   via sudo.
# * delete(path, options={}): deletes the given file or directory from all
#   associated servers. If :recursive => true is given in the options, the
#   delete uses "rm -rf" instead of "rm -f".
# * put(buffer, path, options={}): creates or overwrites a file at "path" on
#   all associated servers, populating it with the contents of "buffer". You
#   can specify :mode as an integer value, which will be used to set the mode
#   on the file.
# * render(template, options={}) or render(options={}): renders the given
#   template and returns a string. Alternatively, if the :template key is given,
#   it will be treated as the contents of the template to render. Any other keys
#   are treated as local variables, which are made available to the (ERb)
#   template.

desc "Demonstrates the various helper methods available to recipes."
task :helper_demo do
  # "setup" is a standard task which sets up the directory structure on the
  # remote servers. It is a good idea to run the "setup" task at least once
  # at the beginning of your app's lifetime (it is non-destructive).
  setup

  buffer = render("maintenance.rhtml", :deadline => ENV['UNTIL'])
  put buffer, "#{shared_path}/system/maintenance.html", :mode => 0644
  sudo "killall -USR1 dispatch.fcgi"
  run "#{release_path}/script/spin"
  delete "#{shared_path}/system/maintenance.html"
end

# You can use "transaction" to indicate that if any of the tasks within it fail,
# all should be rolled back (for each task that specifies an on_rollback
# handler).

desc "A task demonstrating the use of transactions."
task :long_deploy do
  transaction do
    update_code
    disable_web
    symlink
    migrate
  end

  restart
  enable_web
end
