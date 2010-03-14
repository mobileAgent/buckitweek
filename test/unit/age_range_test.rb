require File.dirname(__FILE__) + '/../test_helper'

class AgeRangeTest < Test::Unit::TestCase

  def test_out_of_order_range_should_be_rejected
    # a = Factory.build(:age_range, :low => 20, :high => 10)
    a = AgeRange.new(:low => 20, :high => 10)
    assert ! a.valid?
  end
  
  def test_nil_range_should_be_rejected
    # a = Factory.build(:age_range, :low => 20, :high => nil)
    a = AgeRange.new(:low => 20, :high => nil)
    assert ! a.valid?
  end

  def test_normal_range_is_valid
    #a = Factory.create(:age_range)
    a = AgeRange.make
    assert a.valid?
  end
  
end
