class WaitlistNotification < ActionMailer::Base

  def invoice(user,registration)
     @recipients = user.email
     @from = 'registrar@buckitweek.org'
     @bcc = 'registrar@buckitweek.org'
     @sent_on = Time.now
     @subject = 'BuckitWeek 2008 Waiting List'
     @headers = {}
     @body = make_invoice_text(user,registration)
  end

  private

  def make_invoice_text (user,registration)

     p1 = "#{registration.first_name} #{registration.middle_name} #{registration.last_name}\n"
     p1 += "#{registration.address1}\n"
     if ! registration.address2.nil? && registration.address2.length > 0
        p1 += "#{registration.address2}\n"
     end
     p1 += "#{registration.city} #{registration.state} #{registration.zip_code}\n"

     p2 =  "Phone:  #{registration.phone}\n"
     p2 += "Travel Phone: #{registration.mobile}\n"
     p2 += "Shirt size: #{registration.shirt}\n"

     p3 = "Thank you for your interest for BuckitWeek 2008,\n"
     p3 += "You have been added to the waiting list and we will contact you\n"
     p3 += "if more slots become available.\n"
     p3 += "Please contact registrar@buckitweek.org if you have any questions!\n"

     p4 = "You can update your waiting list registration details at the BuckitWeek\n"
     p4 += "website using your email address and password to login.\n"
     p4 += url_for(:host => "www.buckitweek.org", :controller => "welcome", :action => "index")
      p4 += "\n"

     "#{p1}\n#{p2}\n#{p3}\n#{p4}\n"
  end
end
