# frozen_string_literal: true

module Api
  module V1
    class LikesController < ApplicationController
      def create
        @like = current_user.likes.build(image_id: like_params[:image_id])
        if @like.save!
          render 'api/v1/images/likes/create'
        else
          render json: { error: 'Unable to like this image.' }
        end
      end

      def destroy
        @like = current_user.likes.find_by(image_id: like_params[:image_id])
        if @like.destroy
          render 'api/v1/images/likes/destroy'
        else
          render json: { error: 'Unable to unlike this image.' }
        end
      end

      private

      def like_params
        params.permit(:image_id)
      end
    end
  end
end
