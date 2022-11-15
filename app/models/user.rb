require "securerandom"

class User < ApplicationRecord

  has_secure_password
  validates_confirmation_of :password
  validates :password, length: { minimum: 8 }
  validates :email, presence: true, email: true, uniqueness: true
  has_one :person, dependent: :destroy

  def generate_reset_token
    token = SecureRandom.hex(20)
    User.update(reset_token: token, reset_token_expiry_time: Time.now + 1.hour)
    return token
  end
end