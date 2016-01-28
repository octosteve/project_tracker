Rails.application.routes.draw do
  root "projects#index"
  get '/auth/github/callback', to: 'github_sessions#create'
  resources :projects
end
