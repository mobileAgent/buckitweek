require File.dirname(__FILE__) + '/../test_helper'

class RegistrationTest < Test::Unit::TestCase

  def test_normal_reg_is_valid
    a = FactoryGirl.build(:registration)
    assert a.valid?
    a.user.destroy
    a.event.destroy
    a.age_range.destroy
  end
  
end
