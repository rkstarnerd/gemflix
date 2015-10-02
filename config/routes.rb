Myflix::Application.routes.draw do
  root 'pages#front'
  get 'ui(/:action)', controller: 'ui'
  get 'register',     to: "users#new"
  get '/home',        to: 'videos#index'
  get '/signin',      to: 'sessions#new'
  post '/signin',     to: 'sessions#create'
  get '/signout',     to: 'sessions#destroy'
  get 'my_queue',     to: 'queue_items#index'
  get 'people',       to: 'relationships#index'
  get '/forgot_password', to: 'forgot_passwords#new'

  resources :videos, only: [:index, :show] do
    collection do
      get :search, to: "videos#search"
    end
    resources :reviews, only: [:create, :show]
  end
  resources :categories, only: [:show]
  resources :users
  resources :relationships, only: [:create, :destroy]
  resources :queue_items, only: [:create, :destroy]
  post 'update_queue', to: 'queue_items#update_queue'
end
