# frozen_string_literal: true

FactoryBot.define do
  factory :image do
    transient do
      image_path { 'public/images/test_image.png' }
    end

    image { Rack::Test::UploadedFile.new(image_path) }
    association :user
    association :post

    taken_at { Faker::Date.between(from: 1.year.ago, to: Time.zone.today) }
    created_at { Faker::Date.between(from: 1.year.ago, to: Time.zone.today) }
  end
end
