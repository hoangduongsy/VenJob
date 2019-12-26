Rails.application.routes.draw do
  root "top#index"
  resources :cities, only: :index
  resources :industries, only: :index
  resource :top, only: :index
  devise_for :users
  as :user do
    get "login" => "devise/sessions#new"
    post "login" => "devise/sessions#create"
    delete "logout" => "devise/sessions#destroy"
  end
end
