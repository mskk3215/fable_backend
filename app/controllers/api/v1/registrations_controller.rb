module Api
  module V1
    class RegistrationsController < ApplicationController
      
      def create
        @user = User.new(registrations_params)
        
        if @user.save
          render json:{
            @user, status: :created
          }
        else
          render json:{
            @user.errors, status: :unprocessable_entity
          }
        end

      end
      
      private
      def registrations_params
        params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
      end

    end
  end
end
