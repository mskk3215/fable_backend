class Post < ApplicationRecord

  mount_uploaders :image, ImageUploader
  
  validates :image, presence: true

  # belongs_to :user
  # belongs_to :park
  # has_many :insect_post
end
