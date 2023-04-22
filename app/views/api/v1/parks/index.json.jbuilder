# frozen_string_literal: true

json.array! @parks.map do |park|
  # id, name, post_code, address, latitude, longitude
  json.extract! park, :id, :name, :post_code, :address, :latitude, :longitude
  # image_url
  park_images = Image.where('park_id=?', park.id)
  json.image park_images.map { |image| image.image.url }
  # image_count
  park_image_count = Image.where('park_id=?', park.id).count
  json.image_count park_image_count
  # insect_count in the park
  insect_count = Image.where('park_id=?', park.id).distinct.count(:insect_id)
  json.insect_count insect_count
end
