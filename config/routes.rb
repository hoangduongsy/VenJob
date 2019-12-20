Rails.application.routes.draw do
  root "top#index"
  get "/cities", to: "top#cities"
  resource :top, only: :index
  devise_for :users
end
