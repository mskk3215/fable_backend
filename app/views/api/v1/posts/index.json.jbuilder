# frozen_string_literal: true

json.array! @posts.map do |post|
  json.extract! post, :id, :created_at
  json.avatar post.user.avatar.url
  json.user_id post.user.id
  json.username post.user.nickname
  json.images post.images do |image|
    json.id image.id
    json.image image.image.url
    # insect_name
    insect = Insect.where('id=?', image.insect_id)
    if insect.present?
      json.insect_name insect[0].name
      # insect_sex
      json.insect_sex insect[0].sex
    end
    # park_name
    park_name = Park.where('id=?', image.park_id)
    json.park_name park_name[0].name if park_name.present?
    # city_name
    city_name = City.where('id=?', image.city_id)
    json.city_name city_name[0].name if city_name.present?
    # likes
    json.likes_count image.likes_count
    json.liked_user_ids image.likes.pluck(:user_id)
    # taken_at
    json.taken_at image.taken_at
  end
end
