# frozen_string_literal: true

class Api::V1::SightingNotificationsController < ApplicationController
  before_action :set_sighting_notification, only: %i[destroy]

  def index
    @sighting_notifications = if params[:include_notification_button]
                                # picturebookページの通知設定ボタンおよび通知設定一覧modalのon/off切り替え
                                fetch_notification_settings
                              elsif params[:insect_id]
                                # piturebookページの最近の出没先リストに表示
                                fetch_recent_collected_insects
                              else
                                # notificationページでcurrent_userの通知一覧を表示
                                fetch_current_user_notifications
                              end
    render 'api/v1/sighting_notifications/index'
  end

  def create
    @sighting_notification = current_user.sighting_notifications.build(insect_id: params[:insect_id])
    if @sighting_notification.save
      render 'api/v1/sighting_notifications/create', status: :created
    else
      render json: { error: @sighting_notification.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @sighting_notification.destroy
        render json: { status: :deleted }
    else
      render json: { error: 'Failed to delete notification' }, status: :unprocessable_entity
    end
  end

  private

    def set_sighting_notification
      @sighting_notification = SightingNotification.find(params[:id])
    end

    def fetch_notification_settings
      notifications = current_user.sighting_notifications.where(user_id: current_user.id).includes(:insect)
      notifications.map do |notification|
        {
          id: notification.id,
          insect_id: notification.insect_id,
          insect_name: notification.insect.name
        }
      end
    end

    def fetch_recent_collected_insects
      collected_insects = CollectedInsect.where(insect_id: params[:insect_id]).joins(:insect,
                                                                                     :park).order(taken_date_time: :desc).page(params[:page]).limit(5)
      format_collected_insects(collected_insects)
    end

    def fetch_current_user_notifications
      collected_insects = CollectedInsect.joins(insect: :sighting_notifications)
                                         .joins(:park)
                                         .where(sighting_notifications: { user_id: current_user.id })
                                         .order(taken_date_time: :desc)
                                         .page(params[:page]).per(8)
      format_collected_insects(collected_insects)
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
