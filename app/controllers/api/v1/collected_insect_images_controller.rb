# frozen_string_literal: true

module Api
  module V1
    class CollectedInsectImagesController < ApplicationController
      skip_before_action :ensure_logged_in, only: %i[index]
      before_action :set_collected_insect_image, only: %i[bulk_update destroy]

      def index
        if current_user.present?
          user_id = params[:user_id].presence || current_user.id
          images_query = CollectedInsectImage.where(user_id:).sort_by_option(params[:sort_option].to_i)

          page_size = params[:page_size].presence
          @collected_insect_images = images_query.includes(:insect, :city).page(params[:page]).per(page_size)
        else
          images_query = CollectedInsectImage.where(user_id: params[:user_id])
          @collected_insect_images = images_query.order(created_at: :desc).limit(10)
        end
        @total_images_count = images_query.count
        render 'api/v1/collected_insect_images/index'
      end

      def bulk_update
        form = CollectedInsectImageForm.new(collected_insect_images: @collected_insect_images, collected_insect_image_params:)
        if form.save
          render json: { status: :updated }
        else
          render json: { error: [form.errors.full_messages] }, status: :unprocessable_entity
        end
      end

      def destroy
        @collected_insect_images.each(&:destroy)
        render json: { status: :deleted }
      end

      private

        def collected_insect_image_params
          params.require(:collected_insect_image).permit(:name, :sex, :park_name, :city_name, :taken_at)
        end

        def set_collected_insect_image
          @collected_insect_images = CollectedInsectImage.find(params[:id].split(','))
        end
    end
  end
end
