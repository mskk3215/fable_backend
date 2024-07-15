# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      def index
        posts_query = Post.fetch_all_with_includes

        case params[:tab_value].to_i
        when 0
          @posts = posts_query.page(params[:page]).per(2)
        when 1
          @posts = posts_query.for_followed_users(current_user).page(params[:page]).per(2)
        when 2
          @posts = posts_query.from_the_last_week.page(params[:page]).per(2).sort_by_likes_with_minimum_five
        end
        render 'api/v1/posts/index'
      end

      def create
        form = PostForm.new(current_user:, collected_insect_images: post_params[:images])
        if form.save
          render json: {}, status: :created
        else
          render json: { error: [form.errors.full_messages] }, status: :unprocessable_entity
        end
      end

      def destroy
        post = Post.find(params[:id])
        post.collected_insect_images.each(&:destroy)
        post.destroy
        render json: { status: :deleted }
      end

      private

        def post_params
          params.require(:collected_insect_image).permit(images: [])
        end
    end
  end
end
