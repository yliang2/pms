Rails.application.routes.draw do
  get "login", to: "sessions#new", as: "login"
  root :to => "users#new"
  resources :sessions
  resources :users
  resources :password_resets
end
