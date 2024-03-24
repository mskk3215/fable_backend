# frozen_string_literal: true

FactoryBot.define do
  factory :insect do
    name { "昆虫_#{Faker::Creature::Animal.name}" }
    sex { %w[オス メス].sample }

    association :biological_family, factory: :biological_family
  end
end
