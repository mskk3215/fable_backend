# frozen_string_literal: true

FactoryBot.define do
  factory :park do
    name { Faker::Name.name }

    city factory: %i[city]
    prefecture factory: %i[prefecture]
  end

  factory :prefecture do
    name { Faker::Address.state }
  end

  factory :city do
    name { Faker::Address.city }
    prefecture factory: %i[prefecture]
  end
end
