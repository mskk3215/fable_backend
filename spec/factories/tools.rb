# frozen_string_literal: true

FactoryBot.define do
  factory :tool do
    name { Faker::Name.name }
  end
end
