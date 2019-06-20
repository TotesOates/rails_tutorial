class User < ApplicationRecord
  # id
  # name
  # email
  has_many :microposts
  validates :name, presence: true
  validates :email, presence: true
end
