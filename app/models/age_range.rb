class AgeRange < ActiveRecord::Base

  has_many :registrations
  
  validates_presence_of   :low
  validates_presence_of   :high

  attr_accessible :low, :high

  scope :ordered, :order => "low ASC"

  validate  :range_order
  
  def range_order
    if low.nil? || high.nil? || low >= high
      errors[:base] << "Range out of order"
    end
  end

  def to_s
     "#{low} - #{high}"
  end
end
