require File.dirname(__FILE__) + '/../test_helper'

class UserMailerTest < ActionMailer::TestCase

  def test_invoice_email
    user = User.make
    event = Event.make
    registration = Registration.make(:user => user, :event => event)
    email = UserMailer.deliver_invoice(user,registration)
    assert !ActionMailer::Base.deliveries.empty?

    assert_equal [user.email],email.to
    assert_equal ['registrar@buckitweek.org'],email.from
    assert_equal ['registrar@buckitweek.org'],email.bcc
    assert_equal "Your Invoice for BuckitWeek #{event.year}",email.subject
    assert_match /#{event.start_text}/,email.body
    assert_match /#{registration.amount_owed}.00/,email.body
  end

  def test_password_email
    user = User.make
    email = UserMailer.deliver_password(user,'foodebar')
    assert !ActionMailer::Base.deliveries.empty?
    assert_equal [user.email],email.to
    assert_equal ['registrar@buckitweek.org'],email.from
    assert_equal "Your buckitweek.org password has been reset",email.subject
    assert_match /foodebar/,email.body
  end
  
  def test_waitlist_email
    user = User.make
    event = Event.make
    registration = Registration.make(:user => user, :event => event)
    email = UserMailer.deliver_waitlist(user,registration)
    assert !ActionMailer::Base.deliveries.empty?

    assert_equal [user.email],email.to
    assert_equal ['registrar@buckitweek.org'],email.from
    assert_equal ['registrar@buckitweek.org'],email.bcc
    assert_equal "BuckitWeek #{event.year} Waiting List",email.subject
    assert_match /BuckitWeek #{event.year}/,email.body
  end
  
end
