# frozen_string_literal: true

class BiologicalFamily < ApplicationRecord
  validates :name, presence: true

  has_many :insects, dependent: :destroy
end
