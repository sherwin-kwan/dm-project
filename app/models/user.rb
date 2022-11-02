class User < ApplicationRecord

  has_secure_password
  validates_confirmation_of :password
  validates :password, length: { minimum: 8 }
  validates :email, presence: true, email: true, uniqueness: true
  has_one :person

end