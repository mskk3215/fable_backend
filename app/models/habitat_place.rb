# frozen_string_literal: true

class HabitatPlace < ApplicationRecord
  validates :name, presence: true

  has_many :insect, dependent: :destroy
end
