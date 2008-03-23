class RegistrationController < ApplicationController

  before_filter :authorize, :except => [:register, :index, :create, :noregister]
  before_filter :setup, :only => [:index, :register, :invoice, :create, :delete]

  verify :method => :post, :only => [ :delete, :destroy, :create, :update ],
         :redirect_to => { :action => :register }

   def index
      @title = 'Registration'
      render :action => 'register'
   end

   def register
     @title = 'Registration'
   end

   def noregister
      @title = 'Registration'
   end

   def create
      @registration = Registration.new(params[:registration])
      if !@user || @user.new_record?
         @user = User.new(params[:user])
         @user.last_visit = Time.now
         if ! @user.save
           flash[:notice] = 'There was an error creating your user account'
           render :action => 'register'
           return
         else
           session[:user_id] = @user.id
         end
       end
       @registration.user_id = @user.id
       @registration.event_id = @event.id
       @registration.amount_owed = @event.registration_cost
       if @registration.save
          flash[:notice] = 'Registration created'
          InvoiceNotification.deliver_invoice(@user, @registration)
          redirect_to :action => 'invoice'
       else
          flash[:notice] = 'There was an error in your registration form'
          render :action => 'register'
       end
   end

   def invoice
      @title = 'Invoice'
   end

   def update
     @user = User.find_by_id(session[:user_id])
     @registration = Registration.find(:first, :conditions => ["user_id = ?", @user.id])
     if @registration.update_attributes(params[:registration])
        flash[:notice] = 'Registration Updated'
     else
       flash[:notice] = 'Update failed'
     end
     redirect_to :action => 'register'
   end

   def delete
     if @registration && !@registration.new_record? && @registration.destroy
        flash[:notice] = 'Registration deleted.'
     else
        redirect_to :controller => 'welcome', :action => 'index' and return
     end
   end

   private

   def setup
     @user = User.find_by_id(session[:user_id])
     @event = Event.find_by_year(Time.now.year)
     @registration = @registration ||
         (@user && Registration.find(:first, :conditions => ["user_id = ? and event_id = ?",  @user.id, @event.id ])) ||
         Registration.new(params[:registration])
     if @user && @registration.new_record? && (@registration.last_name.nil? || @registration.last_name == '')
        last_years_ev = Event.find_by_year(@event.year - 1)
        last_years_reg = Registration.find(:first, :conditions => ["user_id = ? and event_id = ?", @user.id, last_years_ev.id])
         if last_years_reg
            @registration = last_years_reg.clone
            @registration.event_id = @event.id
         end
     end
   end

end
