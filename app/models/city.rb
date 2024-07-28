# frozen_string_literal: true

class City < ApplicationRecord
  validates :name, presence: true

  has_many :parks, dependent: :destroy
  has_many :collected_insects, dependent: :destroy

  belongs_to :prefecture
end
