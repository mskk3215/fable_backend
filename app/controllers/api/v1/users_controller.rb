# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def create
        @user = User.new(users_params)

        if @user.save
          reset_session
          login!

          render 'api/v1/users/create'
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end
      private

      def users_params
        params.require(:user).permit(:nickname, :email, :password, :new_password, :avatar)
      end
    end
  end
end
