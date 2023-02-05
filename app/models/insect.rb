class Insect < ApplicationRecord
  validates :name, presence: true
  
  has_many :insect_posts
  has_many :posts, through: :insect_posts

end
