# frozen_string_literal: true

class Insect < ApplicationRecord
  validates :name, presence: true

  has_many :images
  has_many :insect_parks
  has_many :parks, through: :insect_parks
end
