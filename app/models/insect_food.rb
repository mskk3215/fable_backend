# frozen_string_literal: true

class InsectFood < ApplicationRecord
  belongs_to :insect
  belongs_to :food
end
