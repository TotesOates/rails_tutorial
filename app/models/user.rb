class User < ApplicationRecord
  # id
  # name
  # email
  #index on email
  #password_digest used for has_secure_password method
  before_save { email.downcase! }
  has_secure_password

  has_many :microposts

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 250 }, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
end
