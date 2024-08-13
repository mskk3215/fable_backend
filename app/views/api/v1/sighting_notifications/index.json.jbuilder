# frozen_string_literal: true

json.array! @sighting_notifications.map do |notifications|
  json.id notifications[:id]
  json.collected_insect_id notifications[:collected_insect_id]
  json.insect_id notifications[:insect_id]
  json.insect_name notifications[:insect_name]
  json.taken_date_time notifications[:taken_date_time]
  json.park_name notifications[:park_name]
end
