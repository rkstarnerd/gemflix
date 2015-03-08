Myflix::Application.routes.draw do
  root 'videos#index'
  get 'ui(/:action)', controller: 'ui'
  get '/home',        to: 'videos#index'
  

  resources :videos, only: [:index, :show]
  resources :categories, only: [:show]
end
