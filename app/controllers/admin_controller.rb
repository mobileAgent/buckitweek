class AdminController < ApplicationController

   before_filter :authorize_admin

   def index
     @title = 'Adminstration'
   end

   def list_registration
      @title = 'Admin - List Registered'
#      @registration_pages, @registrations =
#         paginate :registrations, :per_page => 25
      @event = Event.find_by_year(2008)
      @registrations = Registration.find(:all, :conditions => ["event_id = ?",@event.id], :order => "last_name")
   end

   def list_events
     @title = 'Admin - List Events'
   end

   def list_age_ranges
      @title = 'Admin - List Age Ranges'
   end

   def show_registration
      @registration = Registration.find(params[:id])
   end

   def destroy_registration
      Registration.destroy(params[:id])
      flash[:notice] = 'One registration was deleted'
      redirect_to :action => 'list_registration'
   end
      

end
