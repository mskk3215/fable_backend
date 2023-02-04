# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      # skip_before_action :authenticate_user!, only: %i[index create]
      before_action :set_post, only:%i[update]
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
      
      def update
        if @post.update(post_params)
          render json:{status: updated}
        else
          render json:{status: 500, error_messages: @post.error_messages}
        end
      end

      def destroy
        post = Post.find(params[:id])
        post.destroy
      end

      private
      def post_params
        binding.pry
        params.require(:post).permit({ image: [] }, :insect_id, :park_id)
      end

      def set_post
        binding.pry
        @post = Post.find(params[:id])
      end

    end
  end
end
