# This defines a deployment "recipe" that you can feed to capistrano
# (http://manuals.rubyonrails.com/read/book/17). It allows you to automate
# (among other things) the deployment of your application.

require 'yaml'

# mongrel has some replacements for restart and spinner:
require 'mongrel_cluster/recipes'

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
  buffer = YAML::load_file('config/database.yml');
  # purge unneeded configurations
  buffer.delete('test');
  buffer.delete('development');

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

  # Rewrite to check for Rails cached page
  RewriteRule ^([^.]+)$ $1.html [QSA]
  
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

desc "Backup the remote production database"
task :backup, :roles => :db, :only => { :primary => true } do
  filename = "#{application}.dump.#{Time.now.to_i}.sql.bz2"
  file = "/tmp/#{filename}"
  on_rollback { delete file }
  db = YAML::load_file("config/database.yml")
  run "mysqldump -u #{db['production']['username']} --password=#{db['production']['password']} #{db['production']['database']} | bzip2 -c > #{file}"  do |ch, stream, data|
    puts data
  end
  `mkdir -p #{File.dirname(__FILE__)}/../backups/`
  get file, "backups/#{filename}"
  delete file
end

desc "Backup the database before running migrations"
task :before_migrate do 
  backup
end
