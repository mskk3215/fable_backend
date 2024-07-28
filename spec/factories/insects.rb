# frozen_string_literal: true

FactoryBot.define do
  factory :insect do
    name { "昆虫_#{Faker::Creature::Animal.name}" }
    size { "#{rand(1..10)}cm" }
    lifespan { "#{rand(1..10)}ヶ月" }

    habitat_place factory: %i[habitat_place]
    biological_family factory: %i[biological_family]
  end
end
