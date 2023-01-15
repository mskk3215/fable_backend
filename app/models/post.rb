class Post < ApplicationRecord

  mount_uploader :image, ImageUploader
  
  validates :image, presence: true
  validates :user_id, presence: true

  belongs_to :user
  # belongs_to :park
  # has_many :insect_post
end
