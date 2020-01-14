Rails.application.routes.draw do
  root "top#index"
  resources :cities, only: :index
  resources :industries, only: :index
  resources :top, only: :index
  resources :users, only: :show
  devise_for :users
  as :user do
    get "login" , to: "devise/sessions#new"
    get "registration/", to: "devise/registrations#new"
    post "registration.user/", to: "devise/registrations#create"
    put "registration.user/", to: "devise/registrations#update"
    get "my/info", to: "devise/registrations#edit"
    get "my/", to: "users#show"
    get "forgot_password", to: "devise/passwords#edit"
    get "reset_password", to: "devise/passwords#new"
    post "forgot_password.user/", to: "devise/passwords#create"
    put "reset_password.user", to: "devise/passwords#update"
  end

  get "jobs/city/:city_id", to: "jobs#index", as: "city_jobs"
  get "jobs/industry/:industry_id", to: "jobs#index", as: "industry_jobs"
  get "detail/:job_id", to: "jobs#show", as: "job"
  get "apply/:job_id", to: "apply#new", as: "apply"
  post "apply/:job_id/", to: "apply#confirm", as: "confirm"
  get "done", to: "apply#done", as: "done"

  concern :paginatable do
    get "(page/:page)", action: :index, on: :collection, as: ""
  end

  resources :jobs, only: :show, concerns: :paginatable
end
