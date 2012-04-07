require File.dirname(__FILE__) + '/../test_helper'

class EventTest < Test::Unit::TestCase

  def test_normal_event_is_valid
    a = FactoryGirl.build(:event)
    assert a.valid?
  end

  def hotel_and_location_in_separate_fields
    a = FactoryGirl.build(:event, :hotel => "Sweet Suites Inn")
    assert a.valid?
  end

  def hotel_confirmed_when_specified
    a = FactoryGirl.build(:event, :hotel => "Sweet Suites Inn")
    assert a.hotel_confirmed?
  end

  def hotel_not_confirmed_when_nil
    a = FactoryGirl.build(:event, :hotel => nil)
    asert ! a.hotel_confirmed?
  end
  
  def hotel_not_confirmed_when_TBD_is_used
    a = FactoryGirl.build(:event, :hotel => 'Some [[TBD]] Hotel')
    asert ! a.hotel_confirmed?
  end

  def event_date_string_collapses_month
    a = FactoryGirl.build(:event, :start_date => '2010-01-01', :end_date => '2010-01-08')
    assert_equal a.event_date_string "January 1-8, 2010"
  end
  
  def event_date_string_specifies_both_months_when_needed
    a = FactoryGirl.build(:event, :start_date => '2010-01-30', :end_date => '2010-02-05')
    assert_equal a.event_date_string "January 30-Febuary 5, 2010"
  end

  def topics_separated_into_array
    a = FactoryGirl.build(:event, :topics => "one; two; three; four; five")
    assert_equal 5, a.topic_list.size
  end

  def event_cost_scaling
    a = FactoryGirl.build(:event,:registration_cost => 100)
    assert_equal a.registration_cost_scale(0), 100
    assert
      a.registration_cost_scale(0) <
      a.registration_cost_scale(1) <
      a.registration_cost_scale(2)
    assert_equal a.registration_cost_scale(2), a.registration_cost_scale(10)
  end
  
end
