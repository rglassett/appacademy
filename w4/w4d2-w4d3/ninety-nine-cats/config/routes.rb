Rails.application.routes.draw do
  root to: 'cats#index'
  
  resources :cats
  
  resources :cat_rental_requests, only: [:new, :create] do
    patch 'approve', to: 'cat_rental_requests#approve'
    patch 'deny', to: 'cat_rental_requests#deny'
  end
  
  resources :users, only: [:new, :create]
  
  resource :session, only: [:new, :create, :destroy]
  
end