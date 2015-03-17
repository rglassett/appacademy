Rails.application.routes.draw do
  root :to => "static_pages#root"
  resources :posts, only: [:create, :update, :destroy, :index, :show]
end
