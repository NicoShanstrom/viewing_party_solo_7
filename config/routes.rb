Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")


  root "welcome#index"
  get '/register', to: 'users#new', as: 'register_user'

  resources :users, only: [:show, :create] do
    member do
      get 'discover'
    end
    resources :movies, only: [:index, :show], controller: 'users/movies'
  end

  # namespace :users do
  #   resources :movies, only: [:index, :show]
  # end
end
