# frozen_string_literal: true

class CollectedInsectImage < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :image, presence: true

  belongs_to :collected_insect
end
