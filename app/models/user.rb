require "securerandom"

class User < ApplicationRecord

  has_secure_password
  has_secure_password :reset_token, validations: false
  validates_confirmation_of :password
  validates :password, length: { minimum: 8 }, unless: :skip_password_verification
  validates :email, presence: true, email: true, uniqueness: true
  has_one :person, dependent: :destroy

  attr_accessor :skip_password_verification

  def generate_reset_token
    token = SecureRandom.hex(20)
    # Note: It's necessary to pass an empty password.
    # If password is not passed during a User.update, the has_secure_password helper will attempt to delete the password!
    self.skip_password_verification = true
    self.update(reset_token: token, password: "", reset_token_expiry_time: Time.now + 1.hour)
    self.skip_password_verification = false
    return token
  end
end