require File.dirname(__FILE__) + '/../test_helper'

class FaqTest < ActiveSupport::TestCase
  def test_normal_faq_is_valid
    a = Faq.make
    assert a.valid?
  end
end
