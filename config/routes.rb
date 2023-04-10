Rails.application.routes.draw do
  get 'categories/index'
  get 'categories/show'
  get 'categories/new'
  get 'signup', to: 'users#new'
  resources :users
  resources :categories
  resources :articles do
    # member do
    #   put 'like' => 'articles#vote'
    # end
    resources :likes
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # get 'sessions/new'
  get 'signup', to: "users#new"
  resources :users
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root "articles#index"
end
