class Insect < ApplicationRecord
  validates :name, presence: true
  
  has_many :insect_posts

end
