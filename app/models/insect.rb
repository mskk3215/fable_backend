class Insect < ApplicationRecord
  validates :name, presence: true
  
  has_many :images

end
