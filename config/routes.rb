Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")


  root "welcome#index"
  get '/register', to: 'users#new', as: 'register_user'

  resources :users, only: [:show, :create] do
    get '/discover', to: 'users#discover', as: 'discover'
    get '/discover/search_by_title', to: 'users#search_by_title', as: 'search_by_title'
  end
end
