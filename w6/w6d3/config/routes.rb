NewAuthDemo::Application.routes.draw do
  resources :users, :only => [:create, :new, :show]
  resources :static_pages, :only => [:home, :about, :contact, :careers]
  resource :session, :only => [:create, :destroy, :new]
  
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get "/home", to: "static_pages#home"
  
  get '404', to: "static_pages#error"
  
  root :to => "static_pages#home"
end
