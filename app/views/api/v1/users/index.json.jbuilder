# frozen_string_literal: true

json.user do
  json.id @user.id
  json.nickname @user.nickname
  json.email @user.email
  json.avatar @user.avatar.url
  json.following @user.following do |following|
    json.id following.id
    json.nickname following.nickname
    json.email following.email
    json.avatar following.avatar.url
  end
  json.followers @user.followers do |followers|
    json.id followers.id
    json.nickname followers.nickname
    json.email followers.email
    json.avatar followers.avatar.url
  end
end
