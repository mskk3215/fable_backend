# frozen_string_literal: true

class City < ApplicationRecord
  validates :name, presence: true
  validates :prefecture_id, presence: true

  has_many :parks
  belongs_to :prefecture
end
