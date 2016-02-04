Rails.application.routes.draw do
  root "projects#index"
  get '/auth/github/callback', to: 'github_sessions#create'
  get 'sign-in', to: "github_sessions#new"
  resources :projects
  post '/webhooks', to: 'webhooks#create'
  get '/projects/:id/screenshot', to: 'projects#take_screenshot', as: 'screenshot'
end
