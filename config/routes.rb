Rails.application.routes.draw do
  resources :trackers
  devise_for :users

  root to: 'measurements#new'

  resources :measurements, only: [:new, :create, :index]
  resource :measurements, only: :show
end
