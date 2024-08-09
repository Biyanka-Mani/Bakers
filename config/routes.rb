Rails.application.routes.draw do

  root 'home#index'
  get '/aboutus', to: 'home#aboutus', as: 'aboutus'
  
  namespace :admin do
    root 'dashboard#index'
    resources :users, only: [:new, :create,:index,:destroy]
    resources :products
    resources :categories
    resources :contact_us_requests,only:[:index,:show,:destroy]
    resources :orders, only: [:index, :show, :update] do
      member do
        patch :update_status
      end
    end
  end
  resources :categories
  resources :products, only: [:index, :show]
  resources :orders, only: [:new, :create, :show] do
    member do
      get 'confirmation'
    end
  end
  resources :order_products
  resources :contact_us_requests

  # resources :carts, only: [:show] do
  #   collection do
  #     post 'add_to_cart'
  #     get 'checkout'
  #     post 'create_order'
  #   end
  # end
  resource :cart, only: [:show] do
    post 'add_to_cart', on: :collection
  end
  get '/checkout', to: 'carts#checkout', as: 'checkout'
  post '/place_order', to: 'carts#place_order', as: 'place_order'
  post 'cart/update', to: 'carts#update', as: 'update_cart'
 post 'cart/remove', to: 'carts#remove', as: 'remove_from_cart'

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
