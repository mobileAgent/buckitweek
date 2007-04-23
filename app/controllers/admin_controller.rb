class AdminController < ApplicationController

   before_filter :authorize_admin

   scaffold :registration, :suffix => true
   scaffold :event, :suffix => true
   scaffold :age_range, :suffix => true

   def index
     @title = 'Adminstration'
   end

end
