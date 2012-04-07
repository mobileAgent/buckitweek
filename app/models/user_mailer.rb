class UserMailer < ActionMailer::Base

  default :from => 'registrar@buckitweek.org'
  default :bcc => 'registrar@buckitweek.org'

  def waitlist(user,registration)
    @user = user
    @registration = registration
    mail(:to => @user.email, :subject => "BuckitWeek #{registration.event.year} Waiting List")
  end

  def password(user,password)
    @user = user
    @password = password
    mail(:to => @user.email, :subject => 'Your buckitweek.org password has been reset')
  end
  
  def invoice(user,registration)
    @user = user
    @registration = registration
    mail(:to => @user.email, :subject => "Your Invoice for BuckitWeek #{@registration.event.year}")
  end

end
