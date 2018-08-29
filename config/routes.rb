Rails.application.routes.draw do

  get '/library', to: 'users#library'
  post '/follow/:id', to: 'users#follow'
  delete '/unfollow/:id', to: 'users#unfollow'

  devise_for :users
  root 'picks#index'
  resources :users, only: [:show]

  get '/picks/search', to: 'picks#search'
  resources :picks, except: [:edit, :update, :destroy]

  resources :relationships, only: [:create, :destroy]
end
