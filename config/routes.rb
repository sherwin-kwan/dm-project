Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "articles#index"
  resources :articles, only: %i(index show)
  namespace :admin do
    resources :articles
    resources :users, only: :index 
    resources :people, only: %i(edit update)
    get "users/dashboard", :to => 'users#dashboard', :as => :dashboard
    get '*path', :to => 'users#dashboard'
  end
  resources :users, only: %i(new create)
  resources :people, only: :show
  scope :users do
    get "login", :to => 'sessions#new'
    post "login", :to => 'sessions#create'
    delete "logout", :to => 'sessions#destroy'
  end

  get '*path', :to => 'application#error', :as => :error
end
