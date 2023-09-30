# frozen_string_literal: true

class Park < ApplicationRecord
  VALID_POSTAL_CODE_REGEX = /\A\d{3}-?\d{4}\z/

  validates :name, presence: true
  validates :post_code, format: { with: VALID_POSTAL_CODE_REGEX }, allow_blank: true

  has_many :images
  has_many :insect_parks, dependent: :destroy
  has_many :insects, through: :insect_parks
  belongs_to :city
  belongs_to :prefecture
end
