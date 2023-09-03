# frozen_string_literal: true

module Api
  module V1
    class ImagesController < ApplicationController
      before_action :set_image, only: %i[bulk_update destroy]

      def index
        user_id = params[:user_id].presence || current_user.id
        @images = Image.where(user_id:).order(created_at: :desc).includes(:insect, :city)
        render 'api/v1/images/index'
      end

      def bulk_update
        ActiveRecord::Base.transaction do
          # insect, cityの事前呼び出し
          insect_names = @images.map { |_image| image_params[:name] }.uniq
          insects = Insect.where(name: insect_names).index_by(&:name)
          city_names = @images.map { |_image| image_params[:cityName] }.uniq
          cities = City.where(name: city_names).index_by(&:name)

          @images.each do |image|
            insect = insects[image_params[:name]]
            city = cities[image_params[:cityName]]
            park = find_or_create_park(image_params[:parkName], city)
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
        params.require(:image).permit({ image: [] }, :name, :sex, :parkName, :cityName, :taken_at)
      end

      def set_image
        @images = Image.find(params[:id].split(','))
      end

      def find_or_create_park(park_name, city)
        # 公園名も市町村名もない場合と、公園名がなく市町村名だけの場合はnilを返す
        return nil if park_name.blank? || city.blank?

        # 公園名がDBにある場合、その公園名を返す
        park = Park.find_or_initialize_by(name: park_name, city_id: city.id)
        # 公園名がDBにない場合、新規でDBに公園名を登録する
        if park.new_record?
          park.prefecture_id = city.prefecture_id
          park.save!
        end
        park
      end
    end
  end
end
