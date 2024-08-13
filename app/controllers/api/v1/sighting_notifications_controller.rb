# frozen_string_literal: true

class Api::V1::SightingNotificationsController < ApplicationController
  def index
    @sighting_notifications = if params[:insect_id]
                                # piturebookページの最近の出没先リストに表示
                                fetch_recent_collected_insects
                              elsif params[:icon_button]
                                # 通知アイコンを未読アイコンにするかどうか
                                fetch_unread_notifications
                              else
                                # notificationページでcurrent_userの通知一覧を表示
                                fetch_current_user_notifications
                              end
    render 'api/v1/sighting_notifications/index'
  end

  private

    def fetch_recent_collected_insects
      collected_insects = CollectedInsect.where(insect_id: params[:insect_id]).joins(:insect,
                                                                                     :park).order(taken_date_time: :desc).page(params[:page]).limit(5)
      collected_insects.flat_map do |collected_insect|
        {
          insect_id: collected_insect.insect_id,
          insect_name: collected_insect.insect.name,
          taken_date_time: collected_insect.taken_date_time,
          park_name: collected_insect.park.name
        }
      end
    end

    def fetch_unread_notifications
      unread_notifications = current_user.sighting_notifications
                                         .includes(collected_insect: %i[insect park])
                                         .where(is_read: false)
                                         .order(updated_at: :desc)
                                         .limit(1)
      format_notifications(unread_notifications)
    end

    def fetch_current_user_notifications
      notifications = current_user.sighting_notifications
                                  .includes(collected_insect: %i[insect park])
                                  .order(updated_at: :desc)
                                  .page(params[:page])
                                  .per(8)
      format_notifications(notifications, mark_as_read: true)
    end

    # format
    def format_notifications(notifications, mark_as_read: false)
      notifications.map do |notification|
        notification.update(is_read: true) if mark_as_read
        {
          insect_id: notification.collected_insect.insect_id,
          insect_name: notification.collected_insect.insect.name,
          taken_date_time: notification.collected_insect.taken_date_time,
          park_name: notification.collected_insect.park&.name,
          is_read: notification.is_read
        }
      end
    end
end
