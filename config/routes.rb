Rails.application.routes.draw do

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  resources :users, only: [:show]
  root 'picks#index'
  get '/picks/search', to: 'picks#search'
  get '/picks/lookup', to: 'picks#lookup'
  resources :picks, except: [:edit, :update, :destroy]
  resources :comments

  resources :relationships, only: [:create, :destroy]

  get '/library', to: 'users#library'
  post '/follow/:id', to: 'users#follow'
  delete '/unfollow/:id', to: 'users#unfollow'

  resources :likes, only: [:create, :destroy]

end
