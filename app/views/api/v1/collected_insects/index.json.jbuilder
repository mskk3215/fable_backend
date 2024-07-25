# frozen_string_literal: true

json.set! :collected_insects do
  json.array! @collected_insects.map do |collected_insect|
    # id, user_id,  park_id, updated_at
    json.extract! collected_insect, :id, :user_id, :park_id, :taken_date_time, :created_at
    # collected_insect_image_id
    json.collected_insect_image_id collected_insect.collected_insect_image.id
    # image_url
    json.image collected_insect.collected_insect_image.image.url
    # insect_name, insect_sex
    json.insect_name collected_insect.insect.try(:name) || ''
    json.insect_sex collected_insect.sex || ''
    # city_name
    json.city_name collected_insect.city.try(:name) || ''
    # likes_count
    json.likes_count collected_insect.likes_count
    # liked_by_user_ids
    json.liked_user_ids collected_insect.likes.pluck(:user_id)
  end
end
json.total_images_count @total_images_count
