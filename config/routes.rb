Rails.application.routes.draw do
  root "cohorts#index"
  get '/auth/github/callback', to: 'github_sessions#create'
  get 'sign-in', to: "github_sessions#new"

  resources :cohorts do
    resources :projects
  end
  post '/webhooks', to: 'webhooks#create'
end
