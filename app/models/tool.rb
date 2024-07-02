# frozen_string_literal: true

class Tool < ApplicationRecord
  validates :name, presence: true

  has_many :insect_tools, dependent: :destroy
  has_many :insects, through: :insect_tools
end
