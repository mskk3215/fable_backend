# frozen_string_literal: true

json.array! @insects do |insect|
  json.id insect[:id]
  json.insect_name insect[:name]
  json.sex insect[:sex]
  json.available_sexes insect[:available_sexes]
  json.biological_family insect[:biological_family]
  json.park_name insect[:park_name]
end
