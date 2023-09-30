# frozen_string_literal: true

json.array! @insects do |insect|
  json.name insect[:name]
  json.availableSexes insect[:availableSexes]
end
