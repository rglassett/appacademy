Rails.application.routes.draw do
  root to: "sessions#new"
  
  concern :commentable do
    resources :comments, only: [:new]
  end
    
  resources :users, concerns: :commentable
  resources :goals, concerns: :commentable
  resources :comments, except: [:new, :index]
  
  get ":commentable_id/comments/new", to: "comments#new", as: "new_comment"
  
  resource :session, only: [ :new, :create, :destroy ]
end
