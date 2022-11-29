Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      post "/signup", to: "registrations#create"

    end
  end
end
