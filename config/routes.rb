# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/login',    to: 'sessions#create', defaults: { format: 'json' }
      delete '/logout', to: 'sessions#destroy'
      get '/logged_in', to: 'sessions#logged_in?', defaults: { format: 'json' }

      resources :users, only: %i[index create update], defaults: { format: 'json' } do
        resources :relationships, only: %i[create destroy], defaults: { format: 'json' }
      end

      resources :images, only: %i[index create destroy], defaults: { format: 'json' }
      put '/images/:id', to: 'images#bulk_update'

      resources :parks, only: %i[index], defaults: { format: 'json' }
      resources :insects, only: %i[index]
      resources :prefectures, only: %i[index]
    end
  end
end
