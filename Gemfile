source 'https://rubygems.org'

gem 'rails', '5.2.8.1'

# Strong parameters is now the default, but Rails 4 ships the
# protected_attributes gem as a back-compat layer so your existing
# attr_accessible code keeps working. Keep this for now; remove during
# the 5.x leg when you actually convert controllers to strong params.
# gem 'protected_attributes'

# Asset pipeline gems bump in lockstep with Rails 4.2
gem 'sass-rails',   '~> 5.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'

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
gem 'bcrypt', '~> 3.1.7'   # was bcrypt-ruby

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

# Test stack — Rails 5+ unblocks newer versions
group :test do
  gem 'rspec-rails',      '~> 4.1.0'   # 4.x supports Rails 5+
  gem 'capybara',         '~> 3.36.0'  # rack 2.x constraint now satisfied

  # Transitive via capybara would get 1.15 which we aren't ready for
  gem 'nokogiri', '~> 1.13.10'

  gem 'database_cleaner', '~> 1.8.5'   # 1.x still fine; 2.x split is optional
  gem 'factory_girl_rails'             # still works; rename later
  gem 'launchy'
  gem 'test-unit',        '~> 3.0'

  # NEW: Rails 5 moved render/assigns/assert_template out of core for
  # controller specs. If you don't have controller specs yet you can skip,
  # but include it now for when you do.
  gem 'rails-controller-testing'
end
