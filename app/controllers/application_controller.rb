class ApplicationController < ActionController::API

  helper_method :login!, :current_user

  def login!
    session[:user_id] = @user.id # sessonにユーザーIDを保持する
  end

  def current_user
    @current_user || = User.find(session[:user_id]) if session[:user_id] #@current_userがUser.find(session[:user_id]でなければUser.find(session[:user_id]を代入する)
  end

end
