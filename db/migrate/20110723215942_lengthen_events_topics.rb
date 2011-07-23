class LengthenEventsTopics < ActiveRecord::Migration
  def self.up
    execute 'alter table events modify column topics varchar(1024)'
  end

  def self.down
  end
end
