Rails.application.routes.draw do
  root to: "decks#index" 
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  get "signup", to: "users#new"
  resources :users, only: [:show, :new, :create]

  resources :decks
  
  get 'question/:question_id/:id', to: 'questions#show'
  get 'answer/:question_id/:id', to: 'questions#answer'
  resources :questions, only: [:create, :destroy]

  resources :cards, except: :show
end
