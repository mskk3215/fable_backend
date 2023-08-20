# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  mount_uploader :avatar, AvatarUploader

  validates :nickname, presence: true, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,    presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  has_many  :images
  has_many  :posts, dependent: :destroy
  has_many :likes, dependent: :destroy

  # follow,followedのrelathionships(中間テーブル)との関連付け
  has_many :active_relationships,  class_name:  'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name:  'Relationship', foreign_key: 'followed_id', dependent: :destroy
  # relathionships(中間テーブル)を使用して、follow,followedを関連付け
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
end
