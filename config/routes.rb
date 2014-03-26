Trotromate::Application.routes.draw do
  root 'projects#index'

  resources :projects do
    resources :tickets
  end

  resources :users

  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'

  namespace :admin do
    root to: 'base#index'
    resources :users
  end
end
