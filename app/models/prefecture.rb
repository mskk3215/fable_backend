# frozen_string_literal: true

class Prefecture < ApplicationRecord
  validates :name, presence: true

  has_many :cities, dependent: :destroy
  has_many :parks, dependent: :destroy
end
