# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :image, counter_cache: :likes_count

  validates :user_id, presence: true, uniqueness: { scope: :image_id }
end
