module Api
  module V1
    class RegistrationsController < ApplicationController
      
      # def index
      #   users = User.all
      #   render json: users
      # end

      def create
        @user = User.new(registrations_params)

        if @user.save
          render json: { status: :created, user: @user
            # @user, status: :created
          }
        else
            render json: { status: 500 }
            # @user.errors, status: :unprocessable_entity
        end
      end
      
      private
      def registrations_params
            params.require(:registration).permit(:nickname, :email, :password, :password_confirmation)
      end

    end
  end
end
