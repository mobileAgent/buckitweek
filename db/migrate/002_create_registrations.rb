class CreateRegistrations < ActiveRecord::Migration
  def self.up
    create_table :registrations do |t|
      t.column :address1, :string, :null => false
      t.column :address2, :string
      t.column :city, :string, :null => false
      t.column :state, :string, :limit => 2
      t.column :phone, :string, :null => false
      t.column :first_name, :string, :null => false
      t.column :last_name, :string, :null => false
      t.column :middle_name, :string
      t.column :age_range_id, :integer, :default => 0, :null => false
      t.column :created_at, :timestamp, :null => false
      t.column :updated_at, :timestamp, :null => false
      t.column :lock_version, :integer, :default => 0, :null => false
      t.column :event_id, :integer
      t.column :amount_paid, :integer, :default => 0, :null => false
      t.column :amount_owed, :integer, :default => 0, :null => false
      t.column :user_id, :integer, :null => false
      t.column :gender, :string, :limit => 1, :null => false
      t.column :zip_code, :string
    end
  end

  def self.down
    drop_table :registrations
  end
end
