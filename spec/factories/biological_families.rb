# frozen_string_literal: true

FactoryBot.define do
  factory :biological_family do
    name { "#{Faker::Science.element}_科" }
  end
end
