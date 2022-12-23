class Post < ApplicationRecord
  validates :image, presence: true

  belongs_to :user
  belongs_to :park
  has_many :insect_post
end
