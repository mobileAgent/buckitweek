source 'https://rubygems.org'

gem 'rails', '4.2.11.3'

# Strong parameters is now the default, but Rails 4 ships the
# protected_attributes gem as a back-compat layer so your existing
# attr_accessible code keeps working. Keep this for now; remove during
# the 5.x leg when you actually convert controllers to strong params.
gem 'protected_attributes'

# Asset pipeline gems bump in lockstep with Rails 4.2
gem 'sass-rails',   '~> 5.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'  # 4.x line works with Rails 4.2

# mysql2 — Rails 4.2's adapter accepts ~> 0.3.13 OR 0.4.x.
# Drop the version pin entirely and let bundler pick.
gem 'mysql2'

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Extracted from core by Rails 4.2
gem 'actionpack-page_caching'

# bigdecimal pin no longer needed in 4.2 — ActiveSupport handles it
# (you can remove the gem 'bigdecimal' line). Keep ffi pin though.
# gem 'bigdecimal', '~> 1.4.4'
gem 'ffi', '~> 1.15.5'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  # gem 'sass-rails',   '~> 3.2.3'
  # gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end

# gem 'jquery-rails'

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
