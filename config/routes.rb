Rails.application.routes.draw do
  root "top#index"
  resources :cities, only: :index
  resources :industries, only: :index
  resources :login, only: :index
  resource :top, only: :index
  devise_for :users
end
