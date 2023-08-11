# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::Cookies
  include ActionController::Helpers
  include ExceptionHandler

  helper_method :login!, :current_user
  before_action :ensure_logged_in

  def login!
    session[:user_id] = @user.id # sessionにユーザーIDを保持する
  end

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find(session[:user_id])
  end

  private

  # ログインしていない場合はエラーを返す
  def ensure_logged_in
    return if current_user
    render json: { status: 'ERROR', message: 'ログインしてください' }, status: :unauthorized
  end
end
