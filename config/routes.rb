Rails.application.routes.draw do
  root "jobs#home"
  resource :jobs
  devise_for :users
end
