# frozen_string_literal: true

class Insect < ApplicationRecord
  validates :name, presence: true
  validates :sex, presence: true
  validates :size, presence: true
  validates :lifespan, presence: true

  has_many :images, dependent: :destroy
  has_many :insect_foods, dependent: :destroy
  has_many :foods, through: :insect_foods
  has_many :insect_tools, dependent: :destroy
  has_many :tools, through: :insect_tools

  belongs_to :habitat_place, dependent: :destroy
  belongs_to :biological_family, dependent: :destroy
end
