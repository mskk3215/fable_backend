# frozen_string_literal: true

class Image < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :image,   presence: true

  belongs_to :insect, optional: true
  belongs_to :park,   optional: true
  belongs_to :city, optional: true
  belongs_to :user
  belongs_to :post

  has_many :likes, dependent: :destroy
  after_initialize :set_default_likes_count, if: :new_record?

  after_destroy :destroy_parent_post_if_no_images

  # likes_countのデフォルト値を設定
  def set_default_likes_count
    self.likes_count ||= 0
  end
  # もしimagesが0ならpostを削除する
  def destroy_parent_post_if_no_images
    post.destroy if post.images.empty?
  end
end
