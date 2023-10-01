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
        ActiveRecord::Base.transaction do
          # insect, cityの事前呼び出し
          insect = Insect.find_by(name: image_params[:name], sex: image_params[:sex]) if image_params[:name].present?
          city = City.find_by(name: image_params[:city_name]) if image_params[:city_name].present?
          park = Park.find_or_create_park(image_params[:park_name], city)
          @images.each do |image|
            attributes = {
              insect_id: insect&.id || image.insect_id,
              park_id: park&.id || image.park_id,
              city_id: city&.id || image.city_id,
              taken_at: image_params[:taken_at].presence || image.taken_at
            }
            # cityがあってparkがない場合はpark_idを削除する
            attributes[:park_id] = nil if city.present? && park.new_record?
            image.update!(attributes)
          end
        end
      rescue ActiveRecord::RecordInvalid
        render json: { error_messages: '予期せぬエラーが発生しました' }, status: 500
      end

      def destroy
        ActiveRecord::Base.transaction do
          @images.each(&:destroy!)
        end
        render json: { status: :deleted }
      rescue ActiveRecord::RecordInvalid
        render json: { error_messages: '予期せぬエラーが発生しました' }, status: 500
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
