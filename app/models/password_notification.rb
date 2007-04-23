class PasswordNotification < ActionMailer::Base

  def password(user,password)
     @recipients = user.email
     @from = 'registrar@buckitweek.org'
     #@bcc = 'registrar@buckitweek.org'
     @sent_on = Time.now
     @subject = 'Your buckitweek.org password has been reset'
     @headers = {}
     @body = "Someone, possibly you, requested a password reset \n" +
             "for your account at buckitweek.org.\n\n" +
             "Your new password is #{password}\n\n" +
             "Logon here: \n" +
             url_for(:host => "www.buckitweek.org", :controller => "login", :action => "login") + "\n"
  end

end
