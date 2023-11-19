# frozen_string_literal: true

json.rankings do
  json.array! @insect_count_by_users do |user|
    json.user_name user[:name]
    json.collection_rate user[:collection_rate]
  end
end
