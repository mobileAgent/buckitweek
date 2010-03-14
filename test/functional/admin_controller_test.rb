require 'test_helper'

class AdminControllerTest < ActionController::TestCase

  def setup
    @user = User.make(:admin => true )
    @request.session[:user_id] = @user.id
  end
  
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should list empty registrations" do
    get :list_registration
    assert_response :success
  end

  test "should list empty registrations as csv" do
    @request.accept = 'text/csv'
    get :list_registration
    assert_response :success
  end

  test "view registration details" do
    e = Event.make
    u = User.make
    r = Registration.make(:event => e, :user => u)
    get :show_registration, :id => r.id.to_param
    assert_response :success
    assert_not_nil assigns(:registration)
  end
  
  test "edit registration details" do
    e = Event.make
    u = User.make
    r = Registration.make(:event => e, :user => u)
    get :edit_registration, :id => r.id.to_param
    assert_response :success
    assert_not_nil assigns(:registration)
  end

  test "update registration details" do
    e = Event.make
    u = User.make
    r = Registration.make(:event => e, :user => u)
    post :update_registration, :id => r.id.to_param, :registration => {:amount_owed => 1000}
    assert_response :redirect
    assert_not_nil assigns(:registration)
    r = Registration.find(r.id)
    assert_equal r.amount_owed, 1000
  end
  
  test "delete registration" do
    e = Event.make
    u = User.make
    r = Registration.make(:event => e, :user => u)
    count = Registration.count
    post :destroy_registration, :id => r.id.to_param
    assert_redirected_to '/admin/list_registration'
    assert_equal Registration.count, count-1
  end
end
