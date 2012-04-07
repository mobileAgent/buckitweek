class AddRegistrationOpenToEvent < ActiveRecord::Migration
  def up
    change_table :events do |t|
      t.boolean :registration_open, :default => false
    end
  end

  def down
    remove_column :events, :registration_open
  end
  
end
