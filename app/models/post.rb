# frozen_string_literal: true

class Post < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :image, presence: true
  validates :user_id, presence: true

  belongs_to :user
  has_many :insects, through: :insect_posts
  belongs_to :park, optional: true
end
