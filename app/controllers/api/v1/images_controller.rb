# frozen_string_literal: true

module Api
  module V1
    class ImagesController < ApplicationController
      skip_before_action :ensure_logged_in, only: %i[index]
      before_action :set_image, only: %i[bulk_update destroy]

      def index
        if current_user.present?
          user_id = params[:user_id].presence || current_user.id
          images_query = Image.where(user_id:).sort_by_option(params[:sort_option].to_i)

          page_size = params[:page_size].presence
          @images = images_query.includes(:insect, :city).page(params[:page]).per(page_size)
          @total_images_count = images_query.count
        else
          @images = Image.where(user_id: params[:user_id]).order(created_at: :desc).limit(12)
        end
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
