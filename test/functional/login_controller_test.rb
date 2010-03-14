require 'test_helper'

class LoginControllerTest < ActionController::TestCase

  test "login with wrong password must fail" do
    @user = User.make(:email => 'foobar@example.com')
    post :login, :params => {:email => @user.email, :password => 'xyzzy'}
    assert_response :success
    assert_select 'p',/.*does not match.*/
    assert_nil @response.session[:user_id]
  end
  
end
