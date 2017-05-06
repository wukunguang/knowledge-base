Rails.application.routes.draw do

  resources :ks, only: [:show, :edit, :update, :destroy]
  resources :users do
    collection do
      get 'logout'
      post 'create'
      get 'index'
      post 'update'
    end
  end
  resources :categories do
    resources :ks, only: [:index, :new, :create]
  end

  resources :ks_search, only: [:index]

  get '/', to: 'guest#index'
  root 'guest#index'
  post 'photos' => 'photo#upload'
  # For Guest Route

  get '/admin', to: 'guest#admin'

  # For user login
  post '/login', to: 'users#login'
  get '/logout', to: 'users#logout'



  # For admin route
  namespace :admin do
    get 'index', to: 'admin#index'
    get 'new', to: 'admin#new'
    get 'manage', to: 'admin#manage'
    get 'users', to: 'admin#users'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
