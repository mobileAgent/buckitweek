require 'test_helper'

class RegistrationControllerTest < ActionController::TestCase
  
  test "when no events the noregistration page is shown" do
    Event.all.each { |e| e.destroy }
    get :register
    assert_template :noregister
  end
  
  test "when event is full waiting list page is shown" do
    Event.all.each { |e| e.destroy }
    @this_year = Event.make(:start_date => Time.now+3,
                            :end_date => Time.now+10,
                            :max_seats => 3)
    3.times { |r| Registration.make(:event => @this_year) } # fill it up
    get :register
    assert_equal assigns(:main_event).id,@this_year.id
    assert_equal assigns(:num_registered),3
    assert_template :registration_full
  end

  test "last years reg info is pulled into current attempt" do
    @myuser = User.make
    @last_year = Event.make(:start_date => Time.now-370, :end_date => Time.now-365)
    @this_year = Event.make(:start_date => Time.now+3, :end_date => Time.now+10)
    @old_reg = Registration.make(:user => @myuser, :event => @last_year,
                                 :first_name => "Captain", :last_name => "Kirk")

    # Now they login for this years registration
    @request.session[:user_id] = @myuser.id

    # And hit the reg page
    get :register

    assert_not_nil assigns(:user), "User should have been assigned"
    assert_not_nil assigns(:registration), "Registration should have been assigned"
    # Like magic last years info appears
    assert_equal assigns(:registration).first_name,@old_reg.first_name
    assert_equal assigns(:registration).last_name,@old_reg.last_name
    assert assigns(:registration).new_record?
  end

  test "registration created on post without a user login" do
    Event.all.each { |e| e.destroy }
    @event = Event.make
    post :create, :registration => Registration.plan(:event => @event),
                  :user => User.plan
    assert_redirected_to '/registration/invoice'
  end

  test "registration update by user" do
    Event.all.each { |e| e.destroy }
    @user = User.make
    @event = Event.make
    @registration = Registration.make(:event => @event, :user => @user)
    @request.session[:user_id] = @user.id
    post :update, :id => @registration.id, :registration => { :first_name => 'William' }
    assert_redirected_to '/registration/register'
    assert_equal Registration.find(@registration.id).first_name, "William"
  end

  test "registration deleted by user" do
    Event.all.each { |e| e.destroy }
    @user = User.make
    @event = Event.make
    @registration = Registration.make(:event => @event, :user => @user)
    @request.session[:user_id] = @user.id
    @count = Registration.count
    post :delete
    assert_equal Registration.count,@count-1,"Registration must be deleted"
    assert_response :success
    assert_template :delete
  end
    
  
end
