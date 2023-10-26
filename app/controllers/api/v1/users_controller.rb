# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :ensure_logged_in, only: %i[create]
      def index
        # ユーザーページの場合は、そのユーザーの情報を取得する
        @user = params[:user_id].present? ? User.find(params[:user_id]) : current_user
        render 'api/v1/users/index'
      end

      def create
        @user = User.new(user_params)

        if @user.save
          reset_session
          login!

          render 'api/v1/users/create'
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

        def user_params
          params.require(:user).permit(:nickname, :email, :password, :new_password, :avatar)
        end
    end
  end
end
