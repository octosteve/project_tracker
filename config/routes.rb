Rails.application.routes.draw do
  get 'videos/create'

  root "projects#index"
  get '/auth/github/callback', to: 'github_sessions#create'
  get 'sign-in', to: "github_sessions#new"
  resources :projects
  post '/webhooks', to: 'webhooks#create'
  post '/videos', to: 'videos#create'
end
