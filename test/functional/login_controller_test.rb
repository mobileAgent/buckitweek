require 'test_helper'

class LoginControllerTest < ActionController::TestCase

  test "login with wrong password must fail" do
    @user = User.make(:email => 'foobar@example.com')
    post :login, :email => @user.email, :password => 'xyzzy'
    assert_response :success
    assert_select 'p',/.*does not match.*/
    assert_nil @response.session[:user_id]
  end
  
  test "login with correct password" do
    @user = User.make(:email => 'foobar@example.com')
    post :login, :email => @user.email, :password => 'secret'
    assert_response :redirect
    assert_match /Hi, #{@user.email}.*/,flash[:notice]
    assert_equal @response.session[:user_id],@user.id
  end

  test "reset password action generates email and saves new password" do
    @user = User.make
    @old_password = @user.password
    post :reset_password, :email => @user.email
    assert !ActionMailer::Base.deliveries.empty?
    @user = User.find(@user.id)
    assert @old_password != @user.password
  end

  test "logout clears session" do
    @user = User.make
    @request.session[:user_id] = @user.id #  login
    get :logout
    assert_nil @request.session[:user_id]
  end

  test "forgotten password page" do
    get :forgotten_password
    assert_select 'title',/Forgotten Password/
  end

  test "login as admin user" do
    @user = User.make(:admin => true)
    post :login, :email => @user.email, :password => 'secret'
    assert_match /Kenichiwa, #{@user.email}.*/,flash[:notice]
    assert_equal @response.session[:user_id],@user.id
  end

  
end
