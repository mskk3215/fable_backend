# frozen_string_literal: true

module Api
  module V1
    class CollectedInsectsController < ApplicationController
      skip_before_action :ensure_logged_in, only: %i[index]
      before_action :set_collected_insects, only: %i[bulk_update destroy]

      def index
        if current_user.present?
          user_id = params[:user_id].presence || current_user.id
          images_query = CollectedInsect.where(user_id:).sort_by_option(params[:sort_option].to_i)
          page_size = params[:page_size].presence
          @collected_insects = images_query.includes(:city, :insect, :collected_insect_image).page(params[:page]).per(page_size)
        else
          images_query = CollectedInsect.where(user_id: params[:user_id])
          @collected_insects = images_query.order(created_at: :desc).limit(10)
        end
        @total_images_count = images_query.count
        render 'api/v1/collected_insects/index'
      end

      def bulk_update
        form = CollectedInsectForm.new(collected_insects: @collected_insects, collected_insect_params:)
        if form.save
          render json: { status: :updated }
        else
          render json: { error: [form.errors.full_messages] }, status: :unprocessable_entity
        end
      end

      def destroy
        @collected_insects.each(&:destroy)
        render json: { status: :deleted }
      end

      private

        def collected_insect_params
          params.require(:collected_insect).permit(:name, :sex, :park_name, :city_name, :taken_date_time)
        end

        def set_collected_insects
          @collected_insects = CollectedInsect.includes(:collected_insect_image).find(params[:id].split(','))
        end
    end
  end
end
