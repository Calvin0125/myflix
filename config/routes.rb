Rails.application.routes.draw do
  root to: 'pages#front'
  get 'home', to: 'videos#index'

  get 'register', to: 'users#new'
  post 'register', to: 'users#create'
  get 'user/:id', to: 'users#show', as: 'user'

  get 'people', to: 'relationships#index', as: 'people'
  delete 'relationship/:id', to: 'relationships#destroy', as: 'destroy_relationship'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy'
  post 'reviews', to: 'reviews#create'
  get 'my_queue', to: 'queue_items#index'
  post 'queue_items', to: 'queue_items#create'
  put 'queue_items', to: 'queue_items#update', as: 'queue_items_update'
  delete 'queue_items/:id', to: 'queue_items#destroy', as: 'queue_items_destroy'

  get 'category/:id', to: 'categories#show', as: 'category'

  resources :videos, only: [:show] do
    collection do
      get 'search', to: 'videos#search'
    end
  end
end
