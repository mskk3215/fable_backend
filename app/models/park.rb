# frozen_string_literal: true

class Park < ApplicationRecord
  VALID_POSTAL_CODE_REGEX = /\A\d{3}-?\d{4}\z/

  validates :name, presence: true
  validates :post_code, presence: true, format: { with: VALID_POSTAL_CODE_REGEX }
  validates :address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  has_many :images
  has_many :insect_parks
  has_many :insects, through: :insect_parks
end
