# frozen_string_literal: true

FactoryBot.define do
  factory :park do
    name { Faker::Name.name }

    association :city, factory: :city
    association :prefecture, factory: :prefecture
  end

  factory :prefecture do
    name { Faker::Address.state }
  end

  factory :city do
    name { Faker::Address.city }
    association :prefecture, factory: :prefecture
  end
end
