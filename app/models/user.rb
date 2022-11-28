class User < ApplicationRecord
  has_many  :posts

  validates :nickname,          presence: true
  validates :email,             presence: true
  validates :encrypted_password,presence: true

end
