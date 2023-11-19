# frozen_string_literal: true

json.statistics do
  json.insect_count @insect_count
  json.collected_insect_count @collected_insect_count
  json.uncollected_insect_count @uncollected_insect_count
  json.collection_rate @collection_rate
end
