# frozen_string_literal: true

json.array! @images.map do |image|
  # id, user_id, insect_id, park_id, updated_at
  json.extract! image, :id, :user_id, :insect_id, :park_id, :taken_at
  # image_url
  json.image image.image.url
  # insect_name,insect_sex
  if insect = Insect.find_by(id: image.insect_id)
    insect_name = insect ? insect.name : ''
    insect_sex = insect ? insect.sex : ''
    json.insect_name insect_name
    json.insect_sex insect_sex
  end
  # city_name
  if city = City.find_by(id: image.city_id)
    city_name = city ? city.name : ''
    json.city_name city_name
  end
end
