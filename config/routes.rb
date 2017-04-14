Rails.application.routes.draw do
  devise_for :users

  resources :measurements, only: [:new, :create, :show]
end
