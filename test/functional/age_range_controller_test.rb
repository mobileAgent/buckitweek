require File.dirname(__FILE__) + '/../test_helper'
require 'age_range_controller'

# Re-raise errors caught by the controller.
class AgeRangeController; def rescue_action(e) raise e end; end

class AgeRangeControllerTest < Test::Unit::TestCase
  def setup
    @controller = AgeRangeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
