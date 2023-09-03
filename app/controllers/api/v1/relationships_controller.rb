# frozen_string_literal: true

module Api
  module V1
    class RelationshipsController < ApplicationController
      before_action :set_user, only: %i[create destroy]

      def create
        ActiveRecord::Base.transaction do
          current_user.following << @user
          current_user.save!
        end
        render 'api/v1/users/relationships/create'
      rescue ActiveRecord::RecordInvalid
        render json: { status: 'ERROR', message: 'follow failed', data: current_user.errors.full_messages },
               status: :unprocessable_entity
      end

      def destroy
        ActiveRecord::Base.transaction do
          current_user.following.delete(@user)
          current_user.save!
        end
        render 'api/v1/users/relationships/destroy'
      rescue ActiveRecord::RecordInvalid
        render json: { status: 'ERROR', message: 'unfollow failed', data: current_user.errors.full_messages },
               status: :unprocessable_entity
      end

      private

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end
