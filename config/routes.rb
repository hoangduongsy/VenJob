Rails.application.routes.draw do
  root "top#index"
  resources :cities, only: :index
  resources :industries, only: :index
  resource :top, only: :index
  resource :users, only: :show
  devise_for :users
  as :user do
    get "login" , to: "devise/sessions#new"
    get "registration/", to: "devise/registrations#new"
    get "my/info", to: "devise/registrations#edit"
    get "my/:id", to: "users#show"
  end
end
