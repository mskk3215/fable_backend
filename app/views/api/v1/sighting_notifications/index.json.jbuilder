# frozen_string_literal: true

json.array! @sighting_notifications.map do |notification|
  json.collected_insect_id notification[:collected_insect_id]
  json.insect_id notification[:insect_id]
  json.insect_name notification[:insect_name]
  json.taken_date_time notification[:taken_date_time]
  json.park_name notification[:park_name]
end
