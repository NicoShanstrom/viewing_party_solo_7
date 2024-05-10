Rails.application.routes.draw do
  get 'user_parties/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")


  root "welcome#index"
  get '/register', to: 'users#new', as: 'register_user'

  resources :users, only: [:show, :create] do
    member do
      get 'discover'
    end
    resources :movies, only: [:index, :show], controller: 'users/movies' do
      resources :viewing_parties, only: [:new, :create, :index], controller: 'users/viewing_parties'
    end
    # resources :user_parties, only: [:index], controller: 'users/user_parties'
  end
end
