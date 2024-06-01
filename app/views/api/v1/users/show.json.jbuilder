# frozen_string_literal: true

json.user do
  json.extract! @user_data, :id, :nickname, :avatar, :email, :following, :followers
end
