Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get '/login', to: 'sessions#new'
  get '/auth/google_oauth2/callback', to: 'sessions#create', as: 'google_auth'
  get '/logout', to: 'sessions#destroy'

  # Defines the root path route ("/")
  root 'tmp#index'
end
