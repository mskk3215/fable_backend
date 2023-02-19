# frozen_string_literal: true

module Api
  module V1
    class ImagesController < ApplicationController
      before_action :set_image, only: %i[bulk_update destroy]
      def index
        image = Image.where(user_id: current_user.id).order(created_at: :desc)
        render json: image
      end

      def create
        ActiveRecord::Base.transaction do
          image_params[:image].each do |image|
            image = Image.new(image:, user: current_user)
            image.save!
          end
        end
      rescue ActiveRecord::RecordInvalid
        render json: { status: 500, error_messages: '予期せぬエラーが発生しました' }
      end

      def bulk_update
        ActiveRecord::Base.transaction do
          @images.each do |image|
            image.update!(image_params)
          end
        end
      rescue ActiveRecord::RecordInvalid
        render json: { status: 500, error_messages: '予期せぬエラーが発生しました' }
      end

      def destroy
        ActiveRecord::Base.transaction do
          @images.each(&:destroy!)
        end
        render json: { status: :deleted }
      rescue ActiveRecord::RecordInvalid
        render json: { status: 500, error_messages: '予期せぬエラーが発生しました' }
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
