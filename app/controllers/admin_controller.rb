class AdminController < ApplicationController

   before_filter :authorize_admin

   def index
     @title = 'Adminstration'
   end

   # GET /admin/list_registration
   # GET /admin/list_registration.csv
   def list_registration
      @title = 'Admin - List Registered'
#      @registration_pages, @registrations =
#         paginate :registrations, :per_page => 25
      @registrations = Registration.find(:all, :conditions => ["event_id = ?",@main_event.id], :order => "last_name")
    respond_to do |format|
      format.html # list_registration.html.erb
      format.xml  { render :xml => @registrations }
      format.csv  # list_registration.csv.erb
    end
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

   def edit_registration
      @registration = Registration.find(params[:id])
   end

   def update_registration
     @registration = Registration.find(params[:id])
     if @registration && @registration.update_attributes(params[:registration])
        flash[:notice] = "#{@registration.first_name} #{@registration.last_name} registration updated"
        redirect_to :action => 'list_registration' and return
     else
       flash[:notice] = 'Update failed'
       render :action => 'edit_registration'
     end
   end

   def destroy_registration
      Registration.destroy(params[:id])
      flash[:notice] = 'One registration was deleted'
      redirect_to :action => 'list_registration' and return
   end

   def edit_faqs
      @faqs = Faq.find(:all, :order => 'list_order')
   end

   def preview_faqs
   end

   def update_faqs
   end

end
