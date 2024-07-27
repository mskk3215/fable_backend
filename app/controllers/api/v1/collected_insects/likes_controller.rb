# frozen_string_literal: true

module Api
  module V1
    module CollectedInsects
      class LikesController < ApplicationController
        def create
          @like = current_user.likes.build(collected_insect_id: like_params[:collected_insect_id])
          if @like.save
            render 'api/v1/collected_insects/likes/create'
          else
            render json: { error: ['いいねをすることができませんでした。'] }, status: :unprocessable_entity
          end
        end

        def destroy
          @like = current_user.likes.find_by(collected_insect_id: like_params[:collected_insect_id])
          if @like
            @like.destroy
            render 'api/v1/collected_insects/likes/destroy'
          else
            render json: { error: ['いいねが見つかりません。'] }, status: :not_found
          end
        end

        private

          def like_params
            params.permit(:collected_insect_id)
          end
      end
    end
  end
end
