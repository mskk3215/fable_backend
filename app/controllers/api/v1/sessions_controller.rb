# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      before_action :current_user

      def create
        @user = User.find_by(email: session_params[:email])

        if @user&.authenticate(session_params[:password])  # hash化したpasswordとDB内のpassword_digestカラムの値を比較する
          reset_session
          login!
          render json: { logged_in: true, user: @user }

        else
          render json: { errors: ['ログインに失敗しました。', '入力した情報を確認して再度お試しください。'] } ,status: :unauthorized
        end
      end

      def destroy
        reset_session
        render json: { status: 200, logged_out: true }
      end

      def logged_in?
        if @current_user
          render json: { logged_in: true, user: current_user }
        else
          render json: { logged_in: false, message: 'ユーザーが存在しません' }
        end
      end

      private

      def session_params
        params.require(:session).permit(:nickname, :email, :password)
      end
    end
  end
end
