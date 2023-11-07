# frozen_string_literal: true

class Insect < ApplicationRecord
  validates :name, presence: true
  validates :sex, presence: true

  has_many :images, dependent: :destroy
  belongs_to :biological_family, dependent: :destroy
end
