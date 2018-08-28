Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    sessions: "users/sessions"
  }
  root 'picks#index'

  get '/picks/search', to: 'picks#search'
  resources :picks, except: [:edit, :update, :destroy]
end
