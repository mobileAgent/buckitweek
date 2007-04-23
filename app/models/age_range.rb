class AgeRange < ActiveRecord::Base

  has_many :registrations

  def to_s
     "#{low} - #{high}"
  end
end
