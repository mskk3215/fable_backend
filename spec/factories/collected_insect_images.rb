# frozen_string_literal: true

FactoryBot.define do
  factory :collected_insect_image do
    transient do
      image_path { 'public/images/test_image.png' }
    end

    image { Rack::Test::UploadedFile.new(image_path) }

    collected_insect

    after(:build) do |image, _evaluator|
      if image.collected_insect&.park
        image.collected_insect.park = create(:park) unless image.collected_insect.park
        image.collected_insect.city = image.collected_insect.park.city
      end
    end
  end
end
