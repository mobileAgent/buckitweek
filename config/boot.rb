require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

require 'bigdecimal'
unless BigDecimal.respond_to?(:new)
  class BigDecimal
    def self.new(*args, &block)
      BigDecimal(*args, &block)
    end
  end
end
