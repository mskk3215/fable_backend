# frozen_string_literal: true

module Api
  module V1
    class RegistrationsController < ApplicationController
      def create
        @user = User.new(registrations_params)

        if @user.save
          reset_session
          login!

          render json: { status: :created, user: @user }
        else
          render json: { status: 500 }
        end
      end

      private

      def registrations_params
        params.require(:registration).permit(:nickname, :email, :password, :password_confirmation)
      end
    end
  end
end
