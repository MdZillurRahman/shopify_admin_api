Rails.application.routes.draw do
  # get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'home#index'

  # resources :shops
  get '/allProduct', to: 'products#all_product'
  get '/addProduct', to: 'products#add_product'
  get '/editProduct', to: 'products#edit_product'

  post '/create_product', to: 'products#create_product', as: 'create_product'
  patch '/update_product', to: 'products#update_product', as: 'update_product'


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
