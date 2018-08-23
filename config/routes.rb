Rails.application.routes.draw do
  devise_for :users
  root 'picks#index'

  resources :picks, except: [:edit, :update, :destroy]
end
