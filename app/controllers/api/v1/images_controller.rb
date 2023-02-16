# frozen_string_literal: true

module Api
  module V1
    class ImagesController < ApplicationController
      before_action :set_image, only: %i[bulk_update]
      def index
        image = Image.where(user_id: current_user.id).order(created_at: :desc)
        render json: image
      end

      def create
        image_params[:image].each do |image|
          image = Image.new(image:, user: current_user)
          render json: image.errors unless image.save
        end
      end

      def bulk_update
        @images.each do |image|
          render json: { status: 500, error_messages: @image.error_messages } unless image.update(image_params)
        end
      end

      private

      def image_params
        params.require(:image).permit({ image: [] }, :insect_id, :park_id)
      end

      def set_image
        @images = Image.find(params[:id].split(','))
      end
    end
  end
end
