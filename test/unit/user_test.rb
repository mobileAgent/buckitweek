require File.dirname(__FILE__) + '/../test_helper'

class UserTest < Test::Unit::TestCase

  def test_normal_user_is_valid
    u = User.make
    assert u.valid?
  end
  
end
