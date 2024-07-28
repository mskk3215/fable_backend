# frozen_string_literal: true

class CollectedInsect < ApplicationRecord
  belongs_to :insect, optional: true
  belongs_to :park, optional: true
  belongs_to :city, optional: true
  belongs_to :user
  belongs_to :post

  has_one :collected_insect_image, dependent: :destroy
  has_many :likes, dependent: :destroy

  after_initialize :set_default_likes_count, if: :new_record?

  after_destroy :destroy_parent_post_if_no_collected_insects

  # likes_countのデフォルト値を設定
  def set_default_likes_count
    self.likes_count ||= 0
  end

  # もしcollected_insectsが0ならpostを削除する
  def destroy_parent_post_if_no_collected_insects
    post.destroy if post.collected_insects.empty?
  end

  # オプションによって並び替える
  def self.sort_by_option(option)
    case option
    when 0 then order(created_at: :desc)
    when 1 then order(taken_date_time: :desc)
    when 2 then order(likes_count: :desc)
    end
  end
end
