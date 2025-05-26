Rails.application.routes.draw do
  resources :user_locations
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  get 'categories/index'
  get 'categories/show'
  get 'categories/new'
  get 'signup', to: 'users#new'
  resources :users
  resources :categories
  resources :articles
  resources :articles do
    # member do
    #   put 'like' => 'articles#vote'
    # end
    resources :likes
  end
  post '/update_coordinates', to: 'locations#update_coordinates'

  get 'signup', to: "users#new"
  resources :users
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root "articles#index"
end
