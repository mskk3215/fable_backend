# frozen_string_literal: true

class Park < ApplicationRecord
  VALID_POSTAL_CODE_REGEX = /\A\d{3}-?\d{4}\z/

  validates :name, presence: true
  validates :post_code, format: { with: VALID_POSTAL_CODE_REGEX }, allow_blank: true

  has_many :images
  belongs_to :city
  belongs_to :prefecture

  # reverse_geocoded_by :latitude, :longitude
  # after_validation :reverse_geocode

  # 公園名と市町村名から公園を検索し、なければ新規で作成する
  def self.find_or_create_park(park_name, city)
    # 公園名がない場合はnilを返す
    return nil if park_name.blank?

    # 公園名がある場合、公園名をDBから検索、なければ新規作成
    park = Park.find_or_initialize_by(name: park_name, city_id: city.id)
    if park.new_record?
      park.prefecture_id = city.prefecture_id
      park.save!
    end
    park
  end
end
