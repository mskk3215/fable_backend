# frozen_string_literal: true

module Api
  module V1
    module Users
      class ProfileController < ApplicationController
        def update
          @user = current_user
          handle_profile_update
        end

        private

          def profile_params
            params.require(:user).permit(:nickname, :email, :avatar)
          end

          def handle_profile_update
            if @user.update(nickname: profile_params[:nickname], email: profile_params[:email],
                            avatar: profile_params[:avatar].presence || @user.avatar)
              render 'api/v1/users/update'
            else
              render json: { error: [@user.errors.full_messages] }, status: :unprocessable_entity
            end
          end
      end
    end
  end
end
