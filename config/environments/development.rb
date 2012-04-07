Buckitweek::Application.configure do
  
  # Settings specified here will take precedence over those in config/environment.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Enable the breakpoint server that script/breakpointer connects to
  #config.breakpoint_server = true

  # Show full error reports and disable caching
  config.consider_all_requests_local = true
  config.action_controller.perform_caching             = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.delivery_method = :test
  
  # Expands the lines which load the assets
  config.assets.debug = true

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr
end
