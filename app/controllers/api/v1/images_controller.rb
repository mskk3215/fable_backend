# frozen_string_literal: true

module Api
  module V1
    class ImagesController < ApplicationController
      before_action :set_image, only: %i[bulk_update destroy]

      def index
        user_id = params[:user_id].presence || current_user.id
        images_query = Image.where(user_id:)

        @images = images_query.order(created_at: :desc).includes(:insect, :city).page(params[:page]).per(20)
        @total_images_count = images_query.count

        render 'api/v1/images/index'
      end

      def bulk_update
        form = ImageForm.new(images: @images, image_params:)
        if form.save
          render json: { status: :updated }
        else
          render json: { error_messages: '予期せぬエラーが発生しました' }, status: 500
        end
      end

      def destroy
        @images.each(&:destroy)
        render json: { status: :deleted }
      end

      private

        def image_params
          params.require(:image).permit( :name, :sex, :park_name, :city_name, :taken_at)
        end

        def set_image
          @images = Image.find(params[:id].split(','))
        end
    end
  end
end
