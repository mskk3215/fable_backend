# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      def index
        @posts = Post.all.order(created_at: :desc)
        render 'api/v1/posts/index'
      end

      def create
        post = Post.new(user: current_user)

        ActiveRecord::Base.transaction do
          if post.save!
            # image_params[:image].each do |img|
            params[:image]['image'].each do |img|
              # imageインスタンスの生成
              image = Image.new(image: img, user: current_user, post:)
              # exifデータから取得したcity_idとtaken_atの登録
              prefecture = Prefecture.find_by(name: image.image.prefecture_name)
              prefecture_id = prefecture ? prefecture.id : nil
              city = City.where('name LIKE ?', "%#{image.image.city_name}%").find_by(prefecture_id:)
              city_id = city ? city.id : nil
              date_time = image.image.taken_at&.strftime('%Y-%m-%d %H:%M:%S.%N')
              image.taken_at = date_time
              image.city_id = city_id
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
          @post = Post.find(params[:id])
          @post.images.each(&:destroy!)
          @post.destroy!
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
