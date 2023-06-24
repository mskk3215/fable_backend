# frozen_string_literal: true

class InsectPark < ApplicationRecord
  belongs_to :insect
  belongs_to :park
end
