Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")


  root "welcome#index"
  get '/register', to: 'users#new', as: 'register_user'

  resources :users, only: [:show, :create] do
    member do
      get 'discover'
    end
    resources :movies, only: [:index, :show], controller: 'users/movies' do
      resources :viewing_parties, only: [:new, :create], controller: 'users/viewing_parties'
    end
  end
end
