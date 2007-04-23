class CreateAgeRanges < ActiveRecord::Migration
  def self.up
    create_table :age_ranges do |t|
      t.column :low, :integer, :null => false
      t.column :high, :integer, :null => false
    end
  end

  def self.down
    drop_table :age_ranges
  end
end
