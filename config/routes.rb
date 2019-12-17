Rails.application.routes.draw do
  root "jobs#index"
  resource :jobs
  devise_for :users
end
