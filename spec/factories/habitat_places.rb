# frozen_string_literal: true

FactoryBot.define do
  factory :habitat_place do
    name { Faker::Name.name }
  end
end
