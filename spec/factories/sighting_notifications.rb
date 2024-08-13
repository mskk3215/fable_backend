# frozen_string_literal: true

FactoryBot.define do
  factory :sighting_notification do
    user
    collected_insect
    is_read { false }
  end
end
