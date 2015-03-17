NewsReader::Application.routes.draw do
  root to: "static_pages#index"
  namespace :api do
    resources :feeds, only: [:destroy, :index, :create, :show] do
      resources :entries, only: [:index]
    end 
    resources :favorite_feeds, only: [:create, :destroy]
  end   
        
  resources :users, only: [:create, :new, :show]
  resource :session, only: [:create, :destroy, :new]
end
