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
            # imageインスタンスの生成
            image = Image.new(image:, user: current_user)
            # exifデータから取得したcity_idとtaken_atの登録
            prefecture_id = Prefecture.find_by(name: image.image.prefecture_name).id
            city_id= City.where("name LIKE ?", "%#{image.image.city_name}%").find_by(prefecture_id: prefecture_id).id
            date_time = image.image.taken_at.strftime('%Y-%m-%d %H:%M:%S.%N')
            image.taken_at = date_time
            image.city_id = city_id
            # imageの保存
            image.save!
          end
        end
      rescue ActiveRecord::RecordInvalid
        render json: { status: 500, error_messages: '予期せぬエラーが発生しました' }
      end

      def bulk_update
        ActiveRecord::Base.transaction do
          @images.each do |image|
            insect = Insect.find_by(name: image_params[:name].split(','), sex: image_params[:sex].split(','))
            city = City.find_by(name: image_params[:cityName])
            park = find_or_create_park(image_params[:parkName], city)

            insect_id = insect&.id || image.insect_id
            park_id = park&.id || image.park_id
            city_id = city&.id || image.city_id
            taken_at = image_params[:taken_at].presence || image.taken_at

            # cityがあってparkがない場合はpark_idを削除する
            park_id = nil if city.present? && park.blank?

            image.update!(insect_id:, park_id:, city_id:, taken_at:)
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
        params.require(:image).permit({ image: [] }, :name, :sex, :parkName, :cityName, :taken_at)
      end

      def set_image
        @images = Image.find(params[:id].split(','))
      end

      def find_or_create_park(park_name, city)
        # 公園名も市町村名もない場合と、公園名がなく市町村名だけの場合はnilを返す
        return nil if park_name.blank? || city.blank?

        # 公園名がDBにある場合、その公園名を返す
        park = Park.find_by(name: park_name, city_id: city.id)
        # 公園名がDBにない場合、新規でDBに公園名を登録する
        if park_name.present? && park.blank? && city.present?
          park = Park.create!(name: park_name, city_id: city.id, prefecture_id: city.prefecture_id)
        end
        park
      end
    end
  end
end
