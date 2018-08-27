Rails.application.routes.draw do
  devise_for :users
  root 'picks#index'

  get '/picks/search', to: 'picks#search'
  resources :picks, except: [:edit, :update, :destroy]

  get '/library', to: 'users#library'
  resources :users, only: [:show]
end
