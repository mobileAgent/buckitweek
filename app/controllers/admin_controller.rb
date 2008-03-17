class AdminController < ApplicationController

   before_filter :authorize_admin

#   scaffold :registration, :suffix => true
#   scaffold :event, :suffix => true
#   scaffold :age_range, :suffix => true

   def index
     @title = 'Adminstration'
   end

   def list_registration
      @title = 'Admin - List Registered'
#      @registration_pages, @registrations =
#         paginate :registrations, :per_page => 25
      Registration.paginate :page => params[:page]
   end

   def list_events
     @title = 'Admin - List Events'
   end

   def list_age_ranges
      @title = 'Admin - List Age Ranges'
   end

end
