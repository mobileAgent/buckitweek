require 'rails_helper'

describe Event do
  describe '#hotel_confirmed?' do
    it 'is false when hotel is blank' do
      event = build(:event, hotel: '')
      expect(event.hotel_confirmed?).to be false
    end

    it 'is false when hotel contains TBD' do
      event = build(:event, hotel: 'TBD - Pending')
      expect(event.hotel_confirmed?).to be false
    end

    it 'is true when hotel is set to a real name' do
      event = build(:event, hotel: 'The Plaza')
      expect(event.hotel_confirmed?).to be true
    end
  end

  describe '#topic_list' do
    it 'splits the topics string on semicolons' do
      event = build(:event, topics: 'Faith;Family;Friends')
      expect(event.topic_list).to eq(%w[Faith Family Friends])
    end
  end

  describe '#speakers' do
    it 'returns only present speakers' do
      event = build(:event,
        speaker_one:   'Alice',
        speaker_two:   nil,
        speaker_three: ''
      )
      expect(event.speakers).to eq(['Alice'])
    end

    it 'returns all three when all are present' do
      event = build(:event,
        speaker_one:   'Alice',
        speaker_two:   'Bob',
        speaker_three: 'Carol'
      )
      expect(event.speakers).to eq(%w[Alice Bob Carol])
    end
  end

  describe '#full_location' do
    it 'combines hotel and location when hotel is confirmed' do
      event = build(:event, hotel: 'The Plaza', location: 'NYC')
      expect(event.full_location).to eq('The Plaza, NYC')
    end

    it 'returns only location when hotel is TBD' do
      event = build(:event, hotel: 'TBD', location: 'NYC')
      expect(event.full_location).to eq('NYC')
    end
  end
end
