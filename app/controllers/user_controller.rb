class UserController < ApplicationController

  before_action :authorize, only: [:change_password, :update_password]

  def add_user
    @user = User.new(signup_params)
    @user.last_visit = Time.now
    if request.post? && @user.save
      flash.now[:notice] = "Account created for #{@user.email}"
      session[:user_id] = @user.id
      uri = session[:original_uri]
      redirect_to(uri || { controller: "welcome", action: "index" })
    end
  end

  def change_password
    @title = 'Change Password'
  end

  def update_password
    user = User.find_by_id(session[:user_id])
    if user && user.update(password_params)
      flash[:notice] = 'Password updated'
      redirect_to controller: "welcome", action: "index"
    else
      flash[:notice] = 'Update failed'
      redirect_to action: 'change_password'
    end
  end

  private

  def signup_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
