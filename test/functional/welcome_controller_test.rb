require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  
  test "should get index without any events" do
    get :index
    assert_response :success
    assert_not_nil assigns(:main_event)
    assert_not_nil assigns(:event_year)
  end

  test "should get index with event loaded" do
    e = Factory.create(:event, :registration_cost => 77, :start_date => Date.today + 365)
    get :index
    assert_response :success
    assert_not_nil assigns(:main_event)
    assert_not_nil assigns(:event_year)
    assert_select 'li', /.*Registration Cost: \$77/
  end    
  
end
