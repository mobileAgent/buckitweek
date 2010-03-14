require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  def setup
    @user = User.make(:admin => true )
    @request.session[:user_id] = @user.id
  end

  test "attempt to get index as non-admin should fail" do
    @user = User.make
    @request.session[:user_id] = @user.id
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
      post :create, :event => Event.plan
    end

    assert_redirected_to event_path(assigns(:event))
  end
  
  test "should show event" do
    a = Event.make
    get :show, :id => a.id.to_param
    assert_response :success
  end

  test "should get edit" do
    a = Event.make
    get :edit, :id => a.id.to_param
    assert_response :success
  end

  test "should update event" do
    a = Event.make
    put :update, :id => a.id.to_param, :event => {:max_seats => 95 }
    assert_redirected_to event_path(assigns(:event))
    a = Event.find(a.id)
    assert_equal(a.max_seats,95)
  end

  test "should destroy event" do
    a = Event.make
    assert_difference('Event.count', -1) do
      delete :destroy, :id => a.id.to_param
    end

    assert_redirected_to events_path
  end
  
  
end
