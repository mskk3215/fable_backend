# frozen_string_literal: true

FactoryBot.define do
  factory :insect do
    name { "昆虫_#{Faker::Creature::Animal.name}" }
    sex { %w[オス メス].sample }

    biological_family factory: %i[biological_family]
  end
end
