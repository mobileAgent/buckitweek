require File.dirname(__FILE__) + '/../test_helper'

class UserMailerTest < ActionMailer::TestCase

  def test_invoice_email
    user = FactoryGirl.build(:user)
    event = FactoryGirl.build(:event)
    registration = FactoryGirl.build(:registration,:user => user, :event => event)
    email = UserMailer.invoice(user,registration).deliver
    assert !ActionMailer::Base.deliveries.empty?

    assert_equal [user.email],email.to
    assert_equal ['registrar@buckitweek.org'],email.from
    assert_equal ['registrar@buckitweek.org'],email.bcc
    assert_equal "Your Invoice for BuckitWeek #{event.year}",email.subject
    assert_match /#{event.start_text}/,email.body.to_s
    assert_match /#{registration.amount_owed}.00/,email.body.to_s
  end

  def test_password_email
    user = FactoryGirl.build(:user)
    email = UserMailer.password(user,'foodebar').deliver
    assert !ActionMailer::Base.deliveries.empty?
    assert_equal [user.email],email.to
    assert_equal ['registrar@buckitweek.org'],email.from
    assert_equal "Your buckitweek.org password has been reset",email.subject
    assert_match /foodebar/,email.body.to_s
  end
  
  def test_waitlist_email
    user = FactoryGirl.build(:user)
    event = FactoryGirl.build(:event)
    registration = FactoryGirl.build(:registration, :user => user, :event => event)
    email = UserMailer.waitlist(user,registration).deliver
    assert !ActionMailer::Base.deliveries.empty?

    assert_equal [user.email],email.to
    assert_equal ['registrar@buckitweek.org'],email.from
    assert_equal ['registrar@buckitweek.org'],email.bcc
    assert_equal "BuckitWeek #{event.year} Waiting List",email.subject
    assert_match /BuckitWeek #{event.year}/,email.body.to_s
  end
  
end
