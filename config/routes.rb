Rails.application.routes.draw do
  devise_for :users

  root to: 'measurements#new'

  resources :measurements, only: [:new, :create]
  resource :measurements, only: :show
end
