# frozen_string_literal: true

class SightingNotification < ApplicationRecord
  validates :is_read, inclusion: { in: [true, false] }

  belongs_to :user
  belongs_to :collected_insect
end
