# frozen_string_literal: true

module Api
  module V1
    class RelationshipsController < ApplicationController
      before_action :set_user, only: %i[create destroy]

      def create
        current_user.following << @user
        render 'api/v1/users/relationships/create'
      rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
        render json: { status: 'ERROR', message: 'follow failed', data: e.message },
               status: :unprocessable_entity
      end

      def destroy
        current_user.following.delete(@user)
        render 'api/v1/users/relationships/destroy'
      rescue ActiveRecord::RecordNotDestroyed => e
        render json: { status: 'ERROR', message: 'unfollow failed', data: e.message },
               status: :unprocessable_entity
      end

      private

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end
