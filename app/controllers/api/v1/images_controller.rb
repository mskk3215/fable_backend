# frozen_string_literal: true

module Api
  module V1
    class ImagesController < ApplicationController
      before_action :set_image, only: %i[bulk_update destroy]

      def index
        @images = Image.where(user_id: current_user.id).order(created_at: :desc)
        render 'api/v1/images/index'
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
            insect = Insect.find_by!(name: image_params[:name].split(','), sex: image_params[:sex].split(','))
            city = City.find_by!(name: image_params[:cityName])
            image.update!(insect_id: insect.id, park_id: image_params[:park_id], city_id: city.id, taken_at: image_params[:taken_at])
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
        params.require(:image).permit({ image: [] }, :name, :sex, :park_id,:cityName, :taken_at)
      end

      def set_image
        @images = Image.find(params[:id].split(','))
      end
    end
  end
end
