Rails.application.routes.draw do
  root to: "decks#index" 
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  get "signup", to: "users#new"
  resources :users, only: [:show, :new, :create]
  
  resources :decks do
    get 'question/:id', to: 'questions#show'
    get 'answer/:id', to: 'questions#answer'
    delete "questions", to: "questions#destroy"
    resources :questions, only: [:create]
  end
  resources :cards, except: :show
end
