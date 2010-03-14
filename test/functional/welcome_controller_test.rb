require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  
  test "should get index without any events" do
    Event.all.each { |e| e.destroy }
    get :index
    assert_response :success
    assert_nil assigns(:main_event)
    assert_not_nil assigns(:event_year)
  end

  test "should get index with event loaded" do
    e = Event.make(:registration_cost => 77, :start_date => Date.today+365, :end_date => Date.today+371, :hotel => "Dew Drop Inn")
    get :index
    assert_response :success
    assert_not_nil assigns(:main_event)
    assert_not_nil assigns(:event_year)
    assert_select 'li', /.*Registration Cost: \$77/
    assert_select 'li', /.*Dew Drop Inn.*/
  end    
  
end
