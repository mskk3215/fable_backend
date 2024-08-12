# frozen_string_literal: true

json.array! @sighting_notification_settings.map do |settings|
  json.id settings[:id]
  json.collected_insect_id settings[:collected_insect_id]
  json.insect_id settings[:insect_id]
  json.insect_name settings[:insect_name]
  json.taken_date_time settings[:taken_date_time]
  json.park_name settings[:park_name]
end
