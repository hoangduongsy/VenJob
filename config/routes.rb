Rails.application.routes.draw do
  root "top#index"
  resource :top, only: :index
  devise_for :users
end
