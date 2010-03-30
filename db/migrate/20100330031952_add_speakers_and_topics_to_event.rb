class AddSpeakersAndTopicsToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :speaker_one, :string
    add_column :events, :speaker_two, :string
    add_column :events, :topics, :string
  end

  def self.down
    remove_column :events, :speaker_one
    remove_column :events, :speaker_two
    remove_column :events, :topics
  end
end
