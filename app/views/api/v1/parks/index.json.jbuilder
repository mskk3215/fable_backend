# frozen_string_literal: true

json.array!(@parks.map) do |park|
  # id, name, post_code, address, latitude, longitude
  json.extract! park, :id, :name, :post_code, :address, :latitude, :longitude
  # prefecture_name
  json.prefecture_name park.prefecture&.name
  # city_name
  json.city_name park.city&.name
  # image_url
  json.images park.collected_insects.filter_map { |collected_insect|
    collected_insect.collected_insect_image&.image&.url
  }
  # image_count
  json.image_count park.collected_insects.joins(:collected_insect_image).count
  # insect_count in the park
  json.insect_count park.collected_insects.pluck(:insect_id).uniq.count
end
