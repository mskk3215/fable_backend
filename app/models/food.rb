# frozen_string_literal: true

class Food < ApplicationRecord
  validates :name, presence: true

  has_many :insect_foods, dependent: :destroy
  has_many :insects, through: :insect_foods
end
