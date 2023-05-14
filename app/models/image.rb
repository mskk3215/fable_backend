# frozen_string_literal: true

class Image < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :image,   presence: true
  validates :user_id, presence: true

  belongs_to :insect, optional: true
  belongs_to :park,   optional: true
  belogs_to :city, optional: true
  belongs_to :user
end
