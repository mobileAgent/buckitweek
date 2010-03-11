require File.dirname(__FILE__) + '/../test_helper'

class EventTest < Test::Unit::TestCase

  def test_normal_event_is_valid
    a = Factory.build(:event)
    assert a.valid?
  end
  
end
