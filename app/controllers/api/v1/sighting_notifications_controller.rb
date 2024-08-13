# frozen_string_literal: true

class Api::V1::SightingNotificationsController < ApplicationController
  def index
    @sighting_notifications = if params[:insect_id]
                                # piturebookページの最近の出没先リストに表示
                                fetch_recent_collected_insects
                              else
                                # notificationページでcurrent_userの通知一覧を表示
                                fetch_current_user_notifications
                              end
    render 'api/v1/sighting_notifications/index'
  end

  def update
    sighting_notification = SightingNotification.find(params[:id])

    if sighting_notification.update(is_read: true)
      render json: { status: 'updated' }, status: :ok
    else
      render json: { error: [sighting_notification.errors.full_messages] }, status: :unprocessable_entity
    end
  end

  private

    def fetch_recent_collected_insects
      collected_insects = CollectedInsect.where(insect_id: params[:insect_id]).joins(:insect,
                                                                                     :park).order(taken_date_time: :desc).page(params[:page]).limit(5)
      format_collected_insects(collected_insects)
    end

    def fetch_current_user_notifications
      current_user.sighting_notifications.includes(collected_insect: %i[insect
                                                                        park]).order(created_at: :desc).page(params[:page]).per(8).map do |notification|
        {
          id: notification.id,
          collected_insect_id: notification.collected_insect_id,
          insect_id: notification.collected_insect.insect_id,
          insect_name: notification.collected_insect.insect.name,
          taken_date_time: notification.collected_insect.taken_date_time,
          park_name: notification.collected_insect.park&.name,
          is_read: notification.is_read
        }
      end
    end

    # format
    def format_collected_insects(collected_insects)
      collected_insects.flat_map do |collected_insect|
        {
          collected_insect_id: collected_insect.id,
          insect_id: collected_insect.insect_id,
          insect_name: collected_insect.insect.name,
          taken_date_time: collected_insect.taken_date_time,
          park_name: collected_insect.park.name
        }
      end
    end
end
