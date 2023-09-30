# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :ensure_logged_in, only: %i[create]
      def index
        @user = if params[:user_id].present?
                  User.find(params[:user_id])
                else
                  current_user
                end
        render 'api/v1/users/index'
      end

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

      def update
        if users_params[:new_password].present?
        @user = current_user
          handle_password_update
        else
          handle_profile_update
        end
      end

      private

        def users_params
          params.require(:user).permit(:nickname, :email, :password, :new_password, :avatar)
        end

        def handle_password_update
          if @user.authenticate(users_params[:password])
            if @user.update(
              password: users_params[:new_password]
            )
              render 'api/v1/users/update'
            else
              render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
            end
          else
            render json: { errors: ['現在のパスワードが間違っています'] }, status: :unprocessable_entity
          end
        end

        def handle_profile_update
          if @user.update(nickname: users_params[:nickname], email: users_params[:email],
                          avatar: users_params[:avatar].presence || @user.avatar)
            render 'api/v1/users/update'
          else
            render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
          end
        end
    end
  end
end
