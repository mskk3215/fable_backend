# frozen_string_literal: true

json.array! @insects do |insect|
  json.id insect[:id]
  json.insect_id insect[:id]
  json.insect_name insect[:name]
  json.sex insect[:sex]
  json.insect_image insect[:image]
  json.biological_family insect[:biological_family]
  json.park_name insect[:park_name]
end
