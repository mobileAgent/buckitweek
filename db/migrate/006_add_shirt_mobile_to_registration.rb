class AddShirtMobileToRegistration < ActiveRecord::Migration
  def self.up
    add_column :registrations, :shirt, :string
    add_column :registrations, :mobile, :string
  end

  def self.down
    remove_column :registrations, :mobile
    remove_column :registrations, :shirt
  end
end
