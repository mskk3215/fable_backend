# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:nickname) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
  end
end
