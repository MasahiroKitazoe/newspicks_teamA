Rails.application.routes.draw do

  get '/library', to: 'users#library'
  resources :users, only: [:show]

  devise_for :users
  root 'picks#index'

  get '/picks/search', to: 'picks#search'
  resources :picks, except: [:edit, :update, :destroy]

  resources :relationships, only: [:create, :destroy]
end
