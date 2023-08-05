# frozen_string_literal: true

json.user do
  json.id @user.id
  json.nickname @user.nickname
  json.email @user.email
  json.avatar @user.avatar.url
end
