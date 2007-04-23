require File.dirname(__FILE__) + '/../test_helper'
require 'registration_controller'

# Re-raise errors caught by the controller.
class RegistrationController; def rescue_action(e) raise e end; end

class RegistrationControllerTest < Test::Unit::TestCase
  def setup
    @controller = RegistrationController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
