require 'test_helper'

class UserControllerTest < ActionController::TestCase
  
  def setup
    @user = User.make
    @request.session[:user_id] = @user.id
  end

  test "get password change screen" do
    get :change_password
    assert_response :success
  end

  test "change of password saved through" do
    post :update_password, :user => {:password => "newpass", :password_confirmation => "newpass" }
    assert_redirected_to root_path
    assert User.authenticate @user.email, "newpass"
  end
  
end
