class InvoiceNotification < ActionMailer::Base

  def invoice(user,registration)
     @recipients = user.email
     @from = 'registrar@buckitweek.org'
     @bcc = 'registrar@buckitweek.org'
     @sent_on = Time.now
     @subject = 'Your invoice for BuckitWeek 2008'
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
     p2 += "Registration Time: #{registration.created_at}\n"
     p2 += "Amount due: $#{registration.amount_owed}.00\n"
     p2 += "You can make your check payable to Buckit Week\n"
     p2 += "And mail it to \n\n"
     p2 += "                 Buckit Week c/o Craig Shakarji\n"
     p2 += "                 3 Arch Place # 425"
     p2 += "                 Gaithersburg MD 20878\n"

     p3 = "Thank you for registering for BuckitWeek 2008,\n"
     p3 += "we are looking forward to seeing you on July 26!\n"
     p3 += "Please contact registrar@buckitweek.org if you have any questions!\n"

     p4 = "You can change your registration details at the BuckitWeek\n"
     p4 += "website using your email address and password to login.\n"
     p4 += url_for(:host => "www.buckitweek.org", :controller => "welcome", :action => "index")
      p4 += "\n"

     "#{p1}\n#{p2}\n#{p3}\n#{p4}\n"
  end
end
