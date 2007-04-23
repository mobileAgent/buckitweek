# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_buckitweek_session_id'


  def authorize
     if !session[:user_id] || !User.find_by_id(session[:user_id])
       session[:original_uri] = request.request_uri
       flash[:notice] = "Please log in"
       redirect_to(:controller => "login", :action => "login")
     end
  end

  def authorize_admin
     session[:original_uri] = request.request_uri
     if session[:user_id]
        user = User.find_by_id(session[:user_id])
        unless user && user.admin?
           redirect_to(:controller => "login", :action => "login")
        end
     else
        redirect_to(:controller => "login", :action => "login")
     end
  end

end
