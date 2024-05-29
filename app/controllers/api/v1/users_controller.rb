# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :ensure_logged_in

      def current
        if current_user
          @user = current_user
          @user_data = user_data(@user)
          render 'api/v1/users/show'
        else
          render json: { error: ['User not logged in'] }, status: :unauthorized
        end
      end

      def show
        @user = User.find(params[:id])
        @user_data = user_data(@user)

        render 'api/v1/users/show'
      end

      def create
        @user = User.new(user_params)

        if @user.save
          reset_session
          login!

          render 'api/v1/users/create'
        else
          render json: { error: [@user.errors.full_messages] }, status: :unprocessable_entity
        end
      end

      private

        def user_params
          params.require(:user).permit(:nickname, :email, :password, :new_password, :avatar)
        end

        def user_data(_user)
          email_condition = (current_user.present? && current_user.id == params[:id].to_i) || params[:id].blank?

          {
            id: @user.id,
            nickname: @user.nickname,
            avatar: @user.avatar.url,
            email: email_condition ? @user.email : nil,
            following: if current_user.present?
                         @user.following.map do |following|
                           {
                             id: following.id,
                             nickname: following.nickname,
                             avatar: following.avatar.url
                           }
                         end
                       end,
            followers: if current_user.present?
                         @user.followers.map do |follower|
                           {
                             id: follower.id,
                             nickname: follower.nickname,
                             avatar: follower.avatar.url
                           }
                         end
                       end
          }
        end
    end
  end
end
