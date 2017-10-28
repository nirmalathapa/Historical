Rails.application.routes.draw do
  resources :trackers do
    resources :measurement_types, only: [:index, :new, :create]
  end

  resources :measurement_types, only: [:edit, :update, :destroy]

  devise_for :users

  root to: 'measurements#new'

  resources :measurements, only: [:new, :create, :index]
  resource :measurements, only: :show
end
