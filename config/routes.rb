Rails.application.routes.draw do
  root to: 'videos#index'
  get 'home', to: 'videos#index'

  get 'register', to: 'users#new'
  post 'register', to: 'users#create'
  get 'signin', to: 'session#new'

  get 'category/:id', to: 'categories#show', as: 'show_category'

  resources :videos, only: [:show] do
    collection do
      get 'search', to: 'videos#search'
    end
  end
end
