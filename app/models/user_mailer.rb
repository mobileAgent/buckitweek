class UserMailer < ActionMailer::Base

  def waitlist(user,registration)
    @user = user
    @registration = registration
    common_setup
    @bcc = 'registrar@buckitweek.org'
    @subject = "BuckitWeek #{registration.event.year} Waiting List"
  end

  def password(user,password)
    @user = user
    @password = password
    common_setup
    @subject = 'Your buckitweek.org password has been reset'
  end
  
  def invoice(user,registration)
    @user = user
    @registration = registration
    common_setup
    @bcc = 'registrar@buckitweek.org'
    @subject = "Your Invoice for BuckitWeek #{@registration.event.year}"
  end

  private

  def common_setup
    @recipients = @user.email
    @from = 'registrar@buckitweek.org'
    @sent_on = Time.now
  end

end
