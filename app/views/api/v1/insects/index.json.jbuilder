# frozen_string_literal: true

if params[:status].present?
  @insects.each_with_index do |insect, index|
    json.array!([insect]) do
      json.id index
      json.insect_name insect[:name]
      json.insect_sex insect[:sex]
      json.biological_family insect[:biological_family]
      json.park_name insect[:park_name]
    end
  end
else
  json.array! @insects do |insect|
    json.name insect[:name]
    json.available_sexes insect[:available_sexes]
  end
end
