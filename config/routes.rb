Rails.application.routes.draw do

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  resources :users, only: [:show]
  root 'picks#index'
  get '/picks/search', to: 'picks#search'
  resources :picks, except: [:edit, :update, :destroy]
  resources :comments

  resources :relationships, only: [:create, :destroy]
  resources :dislikes, only: [:create, :destroy, :show]

  get '/library', to: 'users#library'
  post '/follow/:id', to: 'users#follow'
  delete '/unfollow/:id', to: 'users#unfollow'

  post '/dislike/:id', to: 'users#dislike'
  delete '/undislike/:id', to: 'users#undislike'

  resources :likes, only: [:create, :destroy]

end
