# frozen_string_literal: true

class City < ApplicationRecord
  validates :name, presence: true

  has_many :parks, dependent: :destroy
  belongs_to :prefecture
end
