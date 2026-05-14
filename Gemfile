source 'https://rubygems.org'

gem 'rails', '3.2.22.5'

# gem 'mysql2', '~> 0.4.10'
# gem 'mysql2', '~> 0.3.21'
gem 'mysql2', '~> 0.5.5'

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'ffi', '~> 1.15.5'
gem 'bigdecimal', '~> 1.4.4'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.1.5', require: 'bcrypt'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

gem 'will_paginate',
  :git => 'https://github.com/mislav/will_paginate.git'

gem 'exception_notification'

group :development, :test do
  gem 'thin'
end

group :test do
  gem 'rspec-rails',       '~> 3.9.0'
  gem 'capybara',          '~> 2.18.0'
  gem 'database_cleaner',  '~> 1.8.5'
  gem 'factory_girl_rails'
  gem 'launchy'
  gem 'test-unit',         '~> 3.0'  # required by rspec-rails on Ruby 2.2+
end
