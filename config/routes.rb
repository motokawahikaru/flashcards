Rails.application.routes.draw do
  root to: "decks#index" 
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  get "signup", to: "users#new"
  resources :users, only: [:show, :new, :create]
  
  resources :decks do
    resources :cards, only: [:new, :create, :edit, :update, :destroy]
  end
  
  resources :cards, only: [:index]
end
