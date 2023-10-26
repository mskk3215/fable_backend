# frozen_string_literal: true

class Insect < ApplicationRecord
  validates :name, presence: true
  validates :sex, presence: true

  has_many :images, dependent: :destroy
end
