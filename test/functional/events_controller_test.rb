require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  
  def setup
    @user = FactoryGirl.create(:user, :admin => true )
    session[:user_id] = @user.id
  end

  test "attempt to get index as non-admin should fail" do
    @luser = FactoryGirl.create(:user)
    session[:user_id] = @luser.id # login as non-admin
    get :index
    assert_response :redirect
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should create event" do
    assert_difference('Event.count') do
      post :create, :event => FactoryGirl.attributes_for(:event)
    end

    assert_redirected_to event_path(assigns(:event))
  end
  
  test "should show event" do
    a = FactoryGirl.create(:event)
    get :show, :id => a.id
    assert_response :success
  end

  test "should get edit" do
    a = FactoryGirl.create(:event)
    get :edit, :id => a.id
    assert_response :success
  end

  test "should update event" do
    a = FactoryGirl.create(:event)
    put :update, :id => a.id, :event => {:max_seats => 95 }
    a = Event.find(a.id)
    assert_equal 95,a.max_seats
    assert_redirected_to event_path(assigns(:event))
  end

  test "should destroy event" do
    a = FactoryGirl.create(:event)
    assert_difference('Event.count', -1) do
      delete :destroy, :id => a.id
    end

    assert_redirected_to events_path
  end
  
  
end
