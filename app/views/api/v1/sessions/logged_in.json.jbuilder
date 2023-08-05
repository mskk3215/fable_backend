# frozen_string_literal: true

json.logged_in true
json.user do
  json.id @current_user.id
  json.nickname @current_user.nickname
  json.email @current_user.email
  json.avatar @current_user.avatar.url
end
