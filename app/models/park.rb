# frozen_string_literal: true

class Park < ApplicationRecord
  VALID_POSTAL_CODE_REGEX = /\A\d{3}-?\d{4}\z/

  validates :name, presence: true
  validates :post_code, format: { with: VALID_POSTAL_CODE_REGEX }, allow_blank: true

  has_many :images
  belongs_to :city
  belongs_to :prefecture

  # geocoded_by :full_street_address
  # before_validation :geocode, if: :address_changed?
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  # def full_street_address
  #   [street, city, state, country].compact.join(', ')
  # end

  # 公園名と市町村名から公園を検索し、なければ新規で作成する
  def self.find_or_create_park(park_name, city)
  # 公園名も市町村名もない場合と、公園名がなく市町村名だけの場合はnilを返す
    return nil if park_name.blank? || city.blank?

  # 公園名がDBにある場合、その公園名を返す
    park = Park.find_or_initialize_by(name: park_name, city_id: city.id)
  # 公園名がDBにない場合、新規でDBに公園名を登録する
    if park.new_record?
      park.prefecture_id = city.prefecture_id
      park.save!
    end
    park
  end
end
