Rails.application.routes.draw do

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  resources :users, only: [:show] do
    get 'timeline', on: :member
  end
  root 'picks#index'
  get '/picks/search', to: 'picks#search'
  get '/picks/lookup', to: 'picks#lookup'
  resources :picks, except: [:edit, :update, :destroy]
  resources :comments

  resources :relationships, only: [:create, :destroy]
  resources :dislikes, only: [:create, :destroy, :show]
  post '/dislikes/:id', to: 'dislikes#create'

  get '/library', to: 'users#library'
  post '/follow/:id', to: 'users#follow'
  delete '/unfollow/:id', to: 'users#unfollow'

  resources :likes, only: [:create, :destroy]
  resources :keywords, only: [:create, :destroy]

  get '/themes/technology', to: 'themes#technology'
  get '/themes/business', to: 'themes#business'
  get '/themes/politics_economics', to: 'themes#politics_economics'
  get '/themes/finance', to: 'themes#finance'
  get '/themes/carrier_education', to: 'themes#carrier_education'
  get '/themes/society_sports', to: 'themes#society_sports'
  get '/themes/innovation', to: 'themes#innovation'
  get '/themes/joboffer', to: 'themes#joboffer'

end
