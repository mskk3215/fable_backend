# frozen_string_literal: true

module Api
  module V1
    module Users
      class PasswordController < ApplicationController
        def update
          @user = current_user
          handle_password_update
        end

        private

          def password_params
            params.require(:user).permit(:password, :new_password)
          end

          def handle_password_update
            if @user.authenticate(password_params[:password])
              if @user.update(
                password: password_params[:new_password]
              )
                render 'api/v1/users/update'
              else
                render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
              end
            else
              render json: { errors: ['現在のパスワードが間違っています'] }, status: :unprocessable_entity
            end
          end
      end
    end
  end
end
