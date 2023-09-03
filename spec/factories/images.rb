# frozen_string_literal: true

FactoryBot.define do
  factory :image do
    transient do
      image_path { 'public/images/test_image.png' }
    end

    image { Rack::Test::UploadedFile.new(image_path) }
    association :user
    association :post
  end
end
