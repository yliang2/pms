Rails.application.routes.draw do
  get "login", to: "sessions#new", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"
  root :to => "users#show"
  resources :sessions
  resources :users
  resources :password_resets
end
