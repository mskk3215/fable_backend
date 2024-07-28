# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :collected_insect, counter_cache: :likes_count

  validates :user_id, uniqueness: { scope: :collected_insect_id }
end
