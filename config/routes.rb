Rails.application.routes.draw do
  root to: 'products#index'

  get 'signup', to: 'users#new', as: 'signup'
  post 'signup', to: 'users#create'
  resources :users, only: [:new, :create]

  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  get 'about', to: 'about#index', as: 'about'
  get '/product', to: 'products#show'


  resources :products, only: [:show]
  resources :categories, only: [:show]
  resource :cart, only: [:show] do
    post :add_item
    post :remove_item
  end
  resources :orders, only: [:create, :show]

  namespace :admin do
    get 'dashboard', to: 'dashboard#show'
    resources :products
    resources :categories, only: [:index, :new, :create]
  end
end
