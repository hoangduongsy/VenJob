Rails.application.routes.draw do
  root "top#index"
  devise_for :users

  concern :paginatable do
    get "(page/:page)", action: :index, on: :collection, as: ""
  end

  resources :cities, only: :index
  resources :industries, only: :index
  resources :top, only: :index
  resources :users, only: :show
  resources :favorites, only: :index

  resources :jobs, only: :show, concerns: :paginatable do
    resources :favorites, only: [:create, :destroy]
  end

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
  get "detail/:job_id", to: "jobs#show", as: "job_detail"
  get "apply/:job_id", to: "apply#new", as: "apply"
  post "confirm/:job_id", to: "apply#confirm", as: "confirm"
  post "done/:job_id", to: "apply#done", as: "done"
end
