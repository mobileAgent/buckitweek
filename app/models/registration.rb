class Registration < ActiveRecord::Base

  belongs_to :age_range
  belongs_to :user
  belongs_to :event

  before_validation :normalize

  attr_accessible :age_range_id, :address1, :address2, :city, :state,
                  :zip_code, :phone, :gender, :first_name, :last_name, 
                  :mobile, :country, :comments, :shirt, :middle_name


  validates_presence_of :age_range_id, :message => 'Age Range must be selected'
  validates_presence_of [:address1,:city, :state, :zip_code, :phone]
  validates_format_of :gender, :with => /\A[MF]\Z/i, :message => 'We need gender for room assignment'
  validates_length_of :first_name, :minimum => 2, :message => 'That is too short to be your name'
  validates_length_of :last_name, :minimum => 2, :message => 'That is too short to be your last name'
  validates_length_of :address1, :minimum => 3, :message => 'That is a pretty short address'
  validates_length_of :phone, :minimum => 10, :message => 'Please provide phone number with area code'
  validates_length_of :state, :is => 2, :message => 'Please provide 2 letter state abbreviation'
  validates_format_of :zip_code, :with => /\A[0-9]{5}-?[0-9]*\Z/, :message => 'Bad zip code'
  validates_format_of :phone, :with => /\A[-0-9+., eExXtT()]{10,}\Z/, :message => 'That does not look like a phone number to me'
  validates_format_of :mobile, :with => /\A[-0-9+., eExXtT()]{10,}\Z/, :message => 'That does not look like a phone number to me'

   private

   def normalize
      state.upcase! if state
      gender.upcase! if gender
   end

end
