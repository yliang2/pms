Rails.application.routes.draw do
  get "login", to: "sessions#new", as: "login"
  root :to => "users#new"
  resource :sessions
  resource :users
  resource :password_resets
end
