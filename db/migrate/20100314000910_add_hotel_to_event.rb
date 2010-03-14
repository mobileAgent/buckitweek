class AddHotelToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :hotel, :string
  end

  def self.down
    remove_column :events, :hotel, :string
  end
end
