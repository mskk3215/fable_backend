# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::Cookies
  include ActionController::Helpers
  helper_method :login!, :current_user

  def login!
    session[:user_id] = @user.id # sessionにユーザーIDを保持する
  end

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find(session[:user_id])
  end
end
