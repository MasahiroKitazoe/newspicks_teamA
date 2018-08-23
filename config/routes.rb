Rails.application.routes.draw do
  devise_for :users
  root 'picks#show'
  resources :picks, only: [:show] do
    resources :comments
  end
end
