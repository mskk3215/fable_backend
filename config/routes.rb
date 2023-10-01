# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      # ログイン、ログアウト、ログイン状態の確認
      post '/login',    to: 'sessions#create'
      delete '/logout', to: 'sessions#destroy'
      get '/logged_in', to: 'sessions#logged_in?'
      # ユーザー登録、プロフィール更新、パスワード更新、フォロー、フォロー解除
      resources :users, only: %i[index create update], module: :users do
        resources :relationships, only: %i[create destroy]
      end

      resources :posts, only: %i[index create destroy]

      resources :images, only: %i[index destroy] do
        resources :likes, only: %i[create destroy]
      end
      put '/images/bulk_update', to: 'images#bulk_update' # 一括更新

      resources :parks, only: %i[index]
      resources :insects, only: %i[index]
      resources :prefectures, only: %i[index]
    end
  end
end
