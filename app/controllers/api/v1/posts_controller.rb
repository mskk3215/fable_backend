# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      skip_before_action :authenticate_user!, only: %i[index create]

      def index
        # posts = Post.all.order(created_at: :desc)
        # render json: posts
        post = Post.where(user_id: current_user.id).order(created_at: :desc)
        render json: post

      end

      def create
        post_params[:image].each do |image|
          post = Post.new(image:, user: current_user)
          render json: post.errors unless post.save
        end
      end

      def destroy
        post = Post.find(params[:id])
        post.destroy
      end

      private

      def post_params
        params.require(:post).permit({ image: [] })
      end
    end
  end
end
