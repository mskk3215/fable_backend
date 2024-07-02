class Tool < ApplicationRecord
  validates :name, presence: true

  has_many :insect_tools, dependent: :destroy

end
