Rails.application.routes.draw do
  
  resources :users, only: [:create, :destroy, :index, :show, :update] do
    resources :contact_groups, only: [:index]
    resources :contacts
    resources :comments
  end
  
  resources :contacts, only: [:create, :destroy, :show, :update] do
    resources :contact_groups
    resources :comments
  end
  resources :contact_shares, only: [:create, :destroy]
  
  # get '/users(.:format)' => 'users#index', :as => 'users'
  # post '/users(.:format)' => 'users#create'
  # get '/users/new(.:format)' => 'users#new', :as => 'new_user'
  # get 'users/:id/edit(.:format)' => 'users#edit', :as => 'edit_user'
  # get 'users/:id' => 'users#show', :as => 'user'
  # patch '/users/:id(.:format)' => 'users#update'
  # put '/users/:id(.:format)' => 'users#update'
  # delete '/users/:id(.:format)' => 'users#destroy'
end
