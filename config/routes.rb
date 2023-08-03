# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/login',    to: 'sessions#create'
      resources :users, only: %i[ create], defaults: { format: 'json' }
      delete '/logout', to: 'sessions#destroy'
      get '/logged_in', to: 'sessions#logged_in?'

      resources :images, only: %i[index create destroy], defaults: { format: 'json' }
      put '/images/:id', to: 'images#bulk_update'

      resources :parks, only: %i[index], defaults: { format: 'json' }
      resources :insects, only: %i[index]
      resources :prefectures, only: %i[index]
    end
  end
end
