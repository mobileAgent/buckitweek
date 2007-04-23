class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.column :year, :integer, :null => false
      t.column :location, :string, :null => false
      t.column :registration_cost, :integer, :default => 0, :null => false
      t.column :registration_count, :integer, :default => 0, :null => false
      t.column :max_seats, :integer, :default => 0, :null => false
      t.column :lock_version, :integer, :default => 0, :null => false
      t.column :created_at, :timestamp, :null => false
      t.column :updated_at, :timestamp, :null => false
      t.column :start_date, :timestamp
      t.column :end_date, :timestamp
    end
  end

  def self.down
    drop_table :events
  end
end
