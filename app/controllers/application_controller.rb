# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  protect_from_forgery
  helper :all # include all helpers, all the time
  
  # Get the event we are working on
  before_filter :get_event

  protected

  def get_event
    @main_event = 
      Event.last(:conditions => ["end_date >= ?", Time.now],
                 :order => 'start_date asc')
    @event_year = @main_event ? @main_event.year : Event.count > 0 ? (Event.last.year+1) : (Time.now.year+1)
  end
  
  def authorize
    if !session[:user_id] || !User.find_by_id(session[:user_id])
      session[:original_uri] = request.url
      flash[:notice] = "Please log in for access"
      redirect_to(:controller => "login", :action => "login")
    end
  end

  def authorize_admin
    session[:original_uri] = request.url
    if session[:user_id]
      user = User.find_by_id(session[:user_id])
      unless user && user.admin?
        redirect_to(:controller => "login", :action => "login")
      end
    else
      redirect_to(:controller => "login", :action => "login")
    end
  end

  def admin?
    if session[:user_id]
      user = User.find_by_id(session[:user_id])
      return user && user.admin?
    end
    return false
  end
  

end
