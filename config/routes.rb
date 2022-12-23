Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      post "/signup",   to: "registrations#create"
      post "/login",    to: "sessions#create"
      delete "/logout", to: "sessions#destroy"
      get "/logged_in", to: "sessions#logged_in?"

      get "/posts",     to: "posts#index"
      post "/posts",    to: "posts#create"

    end
  end
end
