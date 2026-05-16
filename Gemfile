source 'https://rubygems.org'

gem 'rails', '6.1.7.10'
gem 'rake'   # explicit so it's never excluded from production bundle

# Strong parameters is now the default, but Rails 4 ships the
# protected_attributes gem as a back-compat layer so your existing
# attr_accessible code keeps working. Keep this for now; remove during
# the 5.x leg when you actually convert controllers to strong params.
# gem 'protected_attributes'

# Asset stack — keep Sprockets, skip Webpacker.
# Rails 6 wants Webpacker as a default but you can opt out
# (much less work right now than rewriting your JS).
gem 'sass-rails', '>= 6'
gem 'jquery-rails'
gem 'logger'
gem 'concurrent-ruby', '< 1.3.5'

# mysql2 — Rails 4.2's adapter accepts ~> 0.3.13 OR 0.4.x.
# Drop the version pin entirely and let bundler pick.
gem 'mysql2'

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Update will_paginate to a released version instead of a git ref.
# git URLs trigger transitive bundler nonsense we don't need.
gem 'will_paginate', '~> 3.3'

# Caching gems
gem 'actionpack-page_caching', '~> 1.2'

gem 'nokogiri'

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

# To use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'   # was bcrypt-ruby

# Deploy with Capistrano (3.x)
group :development do
  gem 'capistrano',         '~> 3.17'
  gem 'capistrano-rails',   '~> 1.6'
  gem 'capistrano-bundler', '~> 2.1'
  gem 'capistrano-rbenv',   '~> 2.2'
end

gem 'exception_notification'

group :development, :test do
  gem 'thin'
end

# Test stack
group :test do
  gem 'rspec-rails',                 '~> 4.1'
  gem 'capybara',                    '~> 3.36.0'
  gem 'database_cleaner-active_record', '~> 2.0'  # 2.x split
  gem 'rails-controller-testing'
  gem 'launchy'
  gem 'factory_girl_rails'
  gem 'test-unit', '~> 3.0'
end
