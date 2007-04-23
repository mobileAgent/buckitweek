require 'digest/sha1'

class User < ActiveRecord::Base

  has_one :registration

  validates_presence_of   :email,
                          :with => /\A[-A-Za-z0-9_\.]+@[-A-Za-z_0-9\.]+\.[A-Za-z]{2,6}\Z/,
                          :message => "is missing or invalid"

  validates_uniqueness_of :email,
                          :on => :create,
                          :message => "is already being used"

  attr_accessor :password_confirmation

  attr_protected :admin

  validates_confirmation_of :password

  def validate
    errors.add_to_base("Missing password") if password.blank?
  end

  def self.authenticate(email,password)
    user = self.find_by_email(email)
    if user
      expected_password = encrypted_password(password,user.salt)
      if user.hashed_password != expected_password
         user = nil
      end
   end
   user
 end

  # Virtual attribute
  def password
    @password
  end

  def password=(pwd)
     @password = pwd
     create_new_salt
     self.hashed_password = User.encrypted_password(self.password, self.salt)
  end

  private

  def self.encrypted_password(password,salt)
     string_to_hash = password + "bUcKiT" + salt
     Digest::SHA1.hexdigest(string_to_hash)
  end

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

end
