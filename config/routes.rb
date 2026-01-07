Rails.application.routes.draw do
  devise_for :users

  resources :books, only: [ :index, :show ]
  resources :users, only: [ :show, :edit, :update ]
  resources :orders, only: [ :show, :create ] do
    post "buy_now", on: :collection
  end
  resources :cart_items, only: [ :create, :update, :destroy ]
  resource :cart, only: [ :show ]


  namespace :stockmanager do
    resources :books
    root to: "books#index"
  end

  namespace :superadmin do
    resources :dashboard
    root to: "dashboard#index"
    patch "update_role/:id", to: "dashboard#update_role", as: :update_role
  end

  namespace :admin do
    resources :users
    root to: "users#index"
  end

  root "books#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
