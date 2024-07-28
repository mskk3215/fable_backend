# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      # ログイン、ログアウト、ログイン状態の確認
      post '/login', to: 'sessions#create'
      delete '/logout', to: 'sessions#destroy'
      get '/logged_in', to: 'sessions#logged_in?'
      # ユーザー登録、プロフィール更新、パスワード更新、フォロー、フォロー解除, 統計情報取得
      resources :users, only: %i[create show] do
        scope module: :users do
          resource :profile, controller: 'profile', only: [:update]
          resource :password, controller: 'password', only: %i[update]
          resources :relationships, only: %i[create destroy]
          resources :statistics, only: %i[index]
        end
      end
      resources :rankings, only: %i[index]

      resources :posts, only: %i[index create destroy]

      resources :collected_insects, only: %i[index destroy] do
        scope module: :collected_insects do
          resources :likes, only: %i[create destroy]
        end
      end
      put '/collected_insects/bulk_update', to: 'collected_insects#bulk_update' # 画像の一括更新

      resources :parks, only: %i[index]
      resources :insects, only: %i[index show]
      resources :prefectures, only: %i[index]
      # AWSヘルスチェック用
      get '/health', to: 'health#index'
    end
  end
end
