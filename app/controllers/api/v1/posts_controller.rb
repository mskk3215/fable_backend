# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      def index
        @posts = Post.all.includes(images: %i[insect park city user likes]).order(created_at: :desc)
        render 'api/v1/posts/index'
      end

      def create
        post = Post.new(user: current_user)
        ActiveRecord::Base.transaction do
          if post.save!
            # prefecture, cityの事前呼び出し
            images = params[:image]['image']

            prefecture_names = images.map { |img| Image.new(image: img).image.prefecture_name }.uniq
            prefectures = Prefecture.where(name: prefecture_names).index_by(&:name)
            city_names = images.map { |img| Image.new(image: img).image.city_name }.uniq
            cities = City.where(name: city_names).group_by(&:name)

            # image_params[:image].each do |img|
            images.each do |img|
              # imageインスタンスの生成
              image = Image.new(image: img, user: current_user, post:)

              # exifデータから取得したcity_idとtaken_atの登録
              prefecture = prefectures[image.image.prefecture_name]
              city = cities[image.image.city_name]&.find { |c| c.prefecture_id == prefecture&.id }

              date_time = image.image.taken_at&.strftime('%Y-%m-%d %H:%M:%S.%N')
              image.assign_attributes(
                taken_at: date_time,
                city_id: city&.id
              )

              # imageの保存
              image.save!
            end
          end
        end
        render json: { status: :created }
      rescue ActiveRecord::RecordInvalid
        render json: { error_messages: '予期せぬエラーが発生しました' }, status: 500
      end

      def destroy
        ActiveRecord::Base.transaction do
          post = Post.find(params[:id])
          post.images.each(&:destroy!)
          post.destroy!
        end
        render json: { status: :deleted }
      rescue ActiveRecord::RecordInvalid
        render json: { error_messages: '予期せぬエラーが発生しました' }, status: 500
      end
    end

    private

    def image_params
      params.require(:image).permit({ image: [] })
    end
  end
end