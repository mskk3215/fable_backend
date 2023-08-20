# frozen_string_literal: true

class Image < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :image,   presence: true
  validates :user_id, presence: true
  validates :post_id, presence: true

  belongs_to :insect, optional: true
  belongs_to :park,   optional: true
  belongs_to :city, optional: true
  belongs_to :user
  belongs_to :post

  has_many :likes, dependent: :destroy
  after_initialize :set_default_likes_count, if: :new_record?

  def set_default_likes_count
    self.likes_count ||= 0
  end
end
