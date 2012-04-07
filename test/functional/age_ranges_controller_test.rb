require 'test_helper'

class AgeRangesControllerTest < ActionController::TestCase
  
  def setup
    @user = FactoryGirl.create(:user, :admin => true )
    session[:user_id] = @user.id
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:age_ranges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create age_range" do
    assert_difference('AgeRange.count') do
      post :create, :age_range => FactoryGirl.attributes_for(:age_range)
    end
    assert_redirected_to age_range_path(assigns(:age_range))
  end

  test "should show age_range" do
    a = FactoryGirl.create(:age_range)
    get :show, { :id => a.id }
    assert_response :success
  end

  test "should get edit" do
    a = FactoryGirl.create(:age_range)
    get :edit, { :id => a.id }
    assert_response :success
  end

  test "should update age_range" do
    a = FactoryGirl.create(:age_range)
    put :update, :id => a.id, :age_range => {:low => 12, :high => 22 }
    assert_redirected_to age_range_path(assigns(:age_range))
  end

  test "should destroy age_range" do
    a = FactoryGirl.create(:age_range)
    assert_difference('AgeRange.count', -1) do
      delete :destroy, :id => a.id
    end

    assert_redirected_to age_ranges_path
  end
end
