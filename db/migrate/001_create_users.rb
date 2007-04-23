class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :email, :string, :limit => 128, :default => "", :null => false
      t.column :hashed_password, :string, :default => "", :null => false
      t.column :salt, :string, :null => false
      t.column :created_at, :timestamp, :null => false
      t.column :last_visit, :timestamp, :null => false
      t.column :admin, :boolean, :default => false, :null => false
      t.column :lock_version, :integer, :default => 0, :null => false
      t.column :activated, :boolean, :default => false, :null => false
    end
  end

  def self.down
    drop_table :users
  end
end
