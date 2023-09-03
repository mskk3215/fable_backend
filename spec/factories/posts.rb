# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    association :user
  end
end
