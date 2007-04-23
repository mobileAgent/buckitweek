require 'active_record/fixtures'

class AddData < ActiveRecord::Migration
  def self.up
    directory = File.join(File.dirname(__FILE__),"dev_data")
    Fixtures.create_fixtures(directory,"age_ranges")

    directory = File.join(File.dirname(__FILE__),"dev_data")
    Fixtures.create_fixtures(directory,"events")
  end

  def self.down
  end
end
