# frozen_string_literal: true

json.array!(@parks.map) do |park|
  # id, name, post_code, address, latitude, longitude
  json.extract! park, :id, :name, :post_code, :address, :latitude, :longitude
  # prefecture_name
  json.prefecture_name park.prefecture&.name
  # city_name
  json.city_name park.city&.name
  # image_url
  park_images = park.collected_insect_images
  json.image park_images.map { |image| image.image.url }
  # image_count
  json.image_count park_images.count
  # insect_count in the park
  insect_count = park_images.distinct.count(:insect_id)
  json.insect_count insect_count
end
