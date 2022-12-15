Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "articles#index"
  resources :articles, only: %i(index show)
  namespace :admin do
    resources :articles
    resources :users, only: :index 
    resource :people, only: %i(edit update) # note singular "resource" to prevent putting IDs in the route
    get "users/dashboard", :to => 'users#dashboard', :as => :dashboard
    get '*path', :to => 'users#dashboard'
  end
  resources :users, only: %i(new create)
  get "get_presigned_url", :to => 'uploads#get_presigned_url'

  # Password resets
  get "password_reset", :to => "sessions#password_reset"
  post "send_password_reset", :to => 'users#send_password_reset'

  resources :people, only: :show
  scope :users do
    get "login", :to => 'sessions#new'
    post "login", :to => 'sessions#create'
    delete "logout", :to => 'sessions#destroy'
  end

  get '*path', :to => 'application#error', :as => :error
end
