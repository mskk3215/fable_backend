# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      def index
        posts_query = Post.fetch_all_with_includes

        case params[:tabValue].to_i
        when 0
          @posts = posts_query.page(params[:page]).per(5)
        when 1
          @posts = posts_query.for_followed_users(current_user).page(params[:page]).per(5)
        when 2
          @posts = posts_query.from_the_last_week.page(params[:page]).per(5).sort_by_recent_likes
        end
        render 'api/v1/posts/index'
      end

      def create
        form = PostForm.new(current_user:, images: post_params[:image])
        if form.save
          render json: { status: :created }
        else
          render json: { error_messages: '予期せぬエラーが発生しました' }, status: 500
        end
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

      private

        def post_params
          params.require(:image).permit({ image: [] })
        end
    end
  end
end
