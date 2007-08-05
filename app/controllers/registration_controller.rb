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
     @registration = Registration.find_first(:user_id => @user.id)
     if @registration.update_attributes(params[:registration])
        flash[:notice] = 'Registration Updated'
     else
       flash[:notice] = 'Update failed'
     end
     redirect_to :action => 'register'
   end

   def delete
     if @registration && !@registration.new_record? && @registration.destroy
        flash[:notice] = 'Registration deleted, sorry to see you go.'
        redirect_to :controller => 'welcome', :action => 'message'
     else
        redirect_to :controller => 'welcome', :action => 'index'
     end
   end

   private

   def setup
     @user = User.find_by_id(session[:user_id])
     @registration = @registration ||
         (@user && Registration.find_first(:user_id => @user.id)) ||
         Registration.new(params[:registration])
     @event = Event.find_by_year(2007)
   end

end
