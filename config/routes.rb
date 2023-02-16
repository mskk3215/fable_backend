# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/signup',   to: 'registrations#create'
      post '/login',    to: 'sessions#create'
      delete '/logout', to: 'sessions#destroy'
      get '/logged_in', to: 'sessions#logged_in?'

      resources :images, only: %i[index create]
      put '/images/:id', to: 'images#bulk_update'

      resources :parks, only: %i[index]
      resources :insects, only: %i[index]
    end
  end
end
