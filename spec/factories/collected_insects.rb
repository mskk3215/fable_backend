# frozen_string_literal: true

FactoryBot.define do
  factory :collected_insect do
    sex { %w[オス メス].sample }
    insect
    user
    post
    park
    city

    taken_date_time { Faker::Date.between(from: 1.year.ago, to: Time.zone.today) }
    created_at { Faker::Date.between(from: 1.year.ago, to: Time.zone.today) }

    after(:create) do |collected_insect|
      create(:collected_insect_image, collected_insect:)
    end
  end
end
