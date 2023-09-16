# frozen_string_literal: true

json.set! :images do
  json.array! @images.map do |image|
    # id, user_id, insect_id, park_id, updated_at
    json.extract! image, :id, :user_id, :insect_id, :park_id, :taken_at, :created_at
    # image_url
    json.image image.image.url
    # insect_name,insect_sex
    if insect = image.insect
      json.insect_name insect.name || ''
      json.insect_sex insect.sex || ''
    end
    # city_name
    if city = image.city
      json.city_name city.name || ''
    end
    # likes_count
    json.likes_count image.likes_count
    # liked_by_user_ids
    json.liked_user_ids image.likes.pluck(:user_id)
  end
end
json.total_images_count @total_images_count
