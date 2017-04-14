Rails.application.routes.draw do
  devise_for :users

  resources :measurements, only: [:new, :create]
  resource :measurements, only: :show
end
