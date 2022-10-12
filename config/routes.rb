Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "articles#index"
  resources :articles, only: %i(index show)
  namespace :admin do
    resources :articles
  end
  resources :users, only: %i(index new create)
  scope :users do
    get "login", :to => 'sessions#new'
    post "login", :to => 'sessions#create'
    delete "logout", :to => 'sessions#destroy'
  end

  get '*path', :to => 'articles#error', :as => :error
end
