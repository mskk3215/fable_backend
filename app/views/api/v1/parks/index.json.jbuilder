# frozen_string_literal: true

json.array! @parks.map do |park|
  # id, name, post_code, address, latitude, longitude
  json.extract! park, :id, :name, :post_code, :address, :latitude, :longitude
  # prefecture_name
  prefecture_name = Prefecture.where('id=?', park.prefecture_id)
  json.prefecture_name prefecture_name[0].name
  # city_name
  city_name = City.where('id=?', park.city_id)
  json.city_name city_name[0].name
  # image_url
  park_images = Image.where('park_id=?', park.id)
  json.image park_images.map { |image| image.image.url }
  # image_count
  park_image_count = park_images.count
  json.image_count park_image_count
  # insect_count in the park
  insect_count = park_images.distinct.count(:insect_id)
  json.insect_count insect_count
end
