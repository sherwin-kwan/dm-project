Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "articles#index"
  resources :articles, only: %i(index show) do
    get '/page/:page', action: :index, on: :collection, :as => :article_page
  end
  get 'error', controller: 'articles', action: :error, :as => :error
  namespace :admin do
    resources :articles
  end
end
