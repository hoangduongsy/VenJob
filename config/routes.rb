Rails.application.routes.draw do
  root to: "jobs#index"
  get 'jobs/index'
  devise_for :users
  resource :jobs do
    collection {post :import}
  end
end
