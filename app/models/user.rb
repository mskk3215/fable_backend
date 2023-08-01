# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  mount_uploader :avatar, AvatarUploader

  validates :nickname, presence: true, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,    presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  has_many  :images
end
