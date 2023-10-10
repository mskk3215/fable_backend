# frozen_string_literal: true

json.array! @insects do |insect|
  json.name insect[:name]
  json.available_sexes insect[:available_sexes]
end
