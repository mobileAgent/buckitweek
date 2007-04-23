class EventController < ApplicationController
  before_filter :authorize_admin
  scaffold :event
  #verify :method => :post, :only => [ :destroy, :create, :update],
  #       :redirect_to => { :action => :list )
end
