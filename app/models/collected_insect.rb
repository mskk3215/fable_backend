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
  has_many :sighting_notifications, dependent: :destroy

  after_destroy :destroy_parent_post_if_no_collected_insects

  # 通知を作成
  def create_sighting_notifications_if_recent_and_insect_changed(current_user)
    # 投稿１時間以内に昆虫名、公園名、撮影日時が追加された場合のみ通知を作成
    return unless recent_post_and_recent_taken? && insect_id.present? && park_id.present? && taken_date_time.present?

    insect.sighting_notification_settings.each do |setting|
      next unless setting.user_id != current_user.id

      notification = SightingNotification.find_by(user_id: setting.user_id, collected_insect_id: id)
      if notification
        notification.update(is_read: false, updated_at: Time.current)
      else
        SightingNotification.create(user_id: setting.user_id, collected_insect_id: id, is_read: false)
      end
    end
  end

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

  private

    def recent_post_and_recent_taken?
      return false if taken_date_time.blank?

      created_at > 1.hour.ago && taken_date_time > 1.week.ago
    end
end
