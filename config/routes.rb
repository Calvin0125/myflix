Rails.application.routes.draw do
  root to: 'pages#front'
  get 'home', to: 'videos#index'

  get 'register', to: 'users#new'
  post 'register', to: 'users#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy'

  get 'category/:id', to: 'categories#show', as: 'show_category'

  resources :videos, only: [:show] do
    collection do
      get 'search', to: 'videos#search'
    end
  end
end
