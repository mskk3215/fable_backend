Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      # resources :registrations, only: [:index]
      resources :registrations, only: [:index, :create]
      # post "/signup", to: "registrations#signup"
    end
  end
end
