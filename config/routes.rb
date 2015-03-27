Myflix::Application.routes.draw do
  root 'videos#front'
  get 'ui(/:action)', controller: 'ui'
  get '/home',        to: 'videos#index'
  get '/signin',      to: 'sessions#new'
  

  resources :videos, only: [:index, :show] do
    collection do
      get :search, to: "videos#search"
    end
  end
  resources :categories, only: [:show]
  resources :users
end
