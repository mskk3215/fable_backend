# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::Cookies
  include ActionController::Helpers
  include ExceptionHandler

  helper_method :login!, :current_user
  before_action :ensure_logged_in
  before_action :check_session_timeout

  def login!
    session[:user_id] = @user.id # sessionにユーザーIDを保持する
  end

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find_by(id: session[:user_id])
  end

  private

    # ログインしていない場合はエラーを返す
    def ensure_logged_in
      return if current_user

      render json: { error: ['ログインしてください'] }, status: :unauthorized
    end

    # sessionタイムアウトした場合はエラーを返す
    def check_session_timeout
      if current_user && session[:last_seen] && session[:last_seen] < 30.minutes.ago
        reset_session
        render json: { error: ['操作がない状態が続いた為、自動ログアウトさせていただきました。'] }, status: :unauthorized
      end
      session[:last_seen] = Time.current
    end
end
