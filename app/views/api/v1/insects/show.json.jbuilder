# frozen_string_literal: true

json.insect do
  json.insect_id @insect.id
  json.name @insect.name
  json.biological_family @insect.biological_family.name
  json.size @insect.size
  json.lifespan @insect.lifespan
  json.habitat_place @insect.habitat_place.name
  json.foods do
    json.array!(@insect.foods.map(&:name))
  end
  json.tools do
    json.array!(@insect.tools.map(&:name))
  end
  json.taken_amount_per_month @taken_amount_per_month
  json.taken_amount_per_hour @taken_amount_per_hour
  json.collected_insect_images @insect.collected_insects.flat_map(&:collected_insect_image).sort_by { |image| -image.collected_insect.likes.count }.map do |image|
    json.url image.image.url
    json.likes_count image.collected_insect.likes.count
  end
  json.image_count @total_insects_count
  json.is_collected @is_collected
end
