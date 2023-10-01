# frozen_string_literal: true

module Api
  module V1
    module Users
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

        def update
          @user = current_user
          if user_params[:new_password].present?
            handle_password_update
          else
            handle_profile_update
          end
        end

        private

          def user_params
            params.require(:user).permit(:nickname, :email, :password, :new_password, :avatar)
          end

          def handle_password_update
            if @user.authenticate(user_params[:password])
              if @user.update(
                password: user_params[:new_password]
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
            if @user.update(nickname: user_params[:nickname], email: user_params[:email],
                            avatar: user_params[:avatar].presence || @user.avatar)
              render 'api/v1/users/update'
            else
              render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
            end
          end
      end
    end
  end
end
