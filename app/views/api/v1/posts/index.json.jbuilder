# frozen_string_literal: true

json.array! @posts.map do |post|
  json.extract! post, :id, :created_at
  json.avatar post.user.avatar.url
  json.user_id post.user.id
  json.username post.user.nickname
  json.collected_insects post.collected_insects do |collected_insect|
    json.id collected_insect.id
    json.image collected_insect.collected_insect_image&.image&.url
    # insect_name
    json.insect_name collected_insect.insect.try(:name) || ''
    # insect_sex
    json.insect_sex collected_insect.sex || ''
    # park_name
    json.park_name collected_insect.park.try(:name) || ''
    # city_name
    json.city_name collected_insect.city.try(:name) || ''
    # likes
    json.likes_count collected_insect.likes_count
    json.liked_user_ids collected_insect.likes.pluck(:user_id)
    # taken_date_time
    json.taken_date_time collected_insect.taken_date_time
  end
end
