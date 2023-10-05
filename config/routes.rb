Rails.application.routes.draw do
   namespace :api do
      namespace :v1 do
        resources :products
        resources :orders, only: [:create, :show]
        resources :users, param: :_username
        post '/auth/login', to: 'authentication#login'
      end
    end
end
