ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require File.expand_path(File.dirname(__FILE__) + "/blueprints")
require 'test_help'
class ActiveSupport::TestCase
  setup { Sham.reset }
  Registration.all.each { |r| r.destroy }
  User.all.each { |u| u.destroy }
  Event.all.each { |e| e.destroy }
  AgeRange.all.each { |a| a.destroy }
end  

