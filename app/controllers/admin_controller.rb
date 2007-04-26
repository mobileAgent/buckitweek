class AdminController < ApplicationController

   before_filter :authorize_admin

   scaffold :registration, :suffix => true
   scaffold :event, :suffix => true
   scaffold :age_range, :suffix => true

   def index
     @title = 'Adminstration'
   end

   def list_registration
      @title = 'Admin - List Registered'
      @registration_pages, @registrations =
         paginate :registrations, :per_page => 25
   end

end
