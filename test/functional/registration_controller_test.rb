require 'test_helper'

class RegistrationControllerTest < ActionController::TestCase
  
  test "get registration page" do
    get :index
    assert_response :success
  end
end
