class AddThirdSpeaker < ActiveRecord::Migration
  def self.up
    add_column :events, :speaker_three, :string
  end

  def self.down
    remove_column :events, :speaker_three
  end
end
