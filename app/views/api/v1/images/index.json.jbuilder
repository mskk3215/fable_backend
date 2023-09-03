# frozen_string_literal: true

json.array! @images.map do |image|
  # id, user_id, insect_id, park_id, updated_at
  json.extract! image, :id, :user_id, :insect_id, :park_id, :taken_at, :created_at
  # image_url
  json.image image.image.url
  # insect_name,insect_sex
    insect_name = insect ? insect.name : ''
    insect_sex = insect ? insect.sex : ''
    json.insect_name insect_name
    json.insect_sex insect_sex
  if insect = image.insect
  end
  # city_name
    city_name = city ? city.name : ''
    json.city_name city_name
  if city = image.city
  end
  # likes_count
  json.likes_count image.likes_count
  # liked_by_user_ids
  json.liked_user_ids image.likes.pluck(:user_id)
end
