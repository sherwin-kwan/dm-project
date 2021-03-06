Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "articles#index"
  resources :articles, only: %i(index show)
  namespace :admin do
    resources :articles
  end

  get '*path', :to => 'articles#error', :as => :error
end
