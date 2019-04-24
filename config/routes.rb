Rails.application.routes.draw do
  root to: "users#new" 
  
  get "signup", to: "users#new"
  get "mypage", to: "users#show"
  resources :users, only: [:show, :new, :create]
end
