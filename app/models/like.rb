# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :collected_insect_image, counter_cache: :likes_count

  validates :user_id, uniqueness: { scope: :collected_insect_image_id }
end
