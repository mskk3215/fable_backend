# frozen_string_literal: true

class Api::V1::SightingNotificationSettingsController < ApplicationController
  before_action :set_sighting_notification_setting, only: %i[destroy]

  def index
    @sighting_notification_settings =
      fetch_sighting_notification_settings

    render 'api/v1/sighting_notification_settings/index'
  end

  def create
    @sighting_notification_setting = current_user.sighting_notification_settings.build(insect_id: params[:insect_id])
    if @sighting_notification_setting.save
      head :created
    else
      render json: { error: [@sighting_notification_setting.errors.full_messages] }, status: :unprocessable_entity
    end
  end

  def destroy
    if @sighting_notification_setting.destroy
      head :no_content
    else
      render json: { error: ['Failed to delete sighting notification setting'] }, status: :unprocessable_entity
    end
  end

  private

    def set_sighting_notification_setting
      @sighting_notification_setting = SightingNotificationSetting.find(params[:id])
    end

    def fetch_sighting_notification_settings
      notifications = current_user.sighting_notification_settings.where(user_id: current_user.id).includes(:insect)
      notifications.map do |notification|
        {
          id: notification.id,
          insect_id: notification.insect_id,
          insect_name: notification.insect.name
        }
      end
    end
end
