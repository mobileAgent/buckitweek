class FaqsController < ApplicationController

   # GET /faqs
   # GET /faqs.xml
   def index
      @title = 'Frequently Asked Questions'
      @faqs = Faq.find(:all, :conditions => "publish = true", :order => 'list_order')
      respond_to do |format|
         format.html # index.html.erb
         format.xml  { render :xml => @faqs }
      end
   end

  # GET /faqs/1
  # GET /faqs/1.xml
  def show
    @faq = Faq.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @faq }
    end
  end

end
