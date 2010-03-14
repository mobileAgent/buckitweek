class AgeRange < ActiveRecord::Base

  has_many :registrations
  
  validates_presence_of   :low
  validates_presence_of   :high

  named_scope :ordered, :order => "low ASC"
  
  
  def validate
    if low.nil? || high.nil? || low >= high
      errors.add_to_base("Range out of order")
    end
  end

  def to_s
     "#{low} - #{high}"
  end
end
