# frozen_string_literal: true

FactoryBot.define do
  factory :food do
    name { Faker::Name.name }
  end
end
