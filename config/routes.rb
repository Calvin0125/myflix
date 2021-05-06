Rails.application.routes.draw do
  root to: 'pages#front'
  get 'home', to: 'videos#index', as: 'home'

  get 'register', to: 'users#new'
  post 'register', to: 'users#create'
  get 'user/:id', to: 'users#show', as: 'user'
  get 'forgot_password', to: 'users#forgot_password', as: 'forgot_password'
  post 'forgot_password', to: 'users#forgot_password'
  get 'reset_password_confirmation', to: 'users#reset_password_confirmation', as: 'reset_password_confirmation'
  get 'reset_password/:token', to: 'users#reset_password', as: 'reset_password'
  post 'reset_password', to: 'users#reset_password'

  get 'people', to: 'relationships#index', as: 'people'
  delete 'relationship/:id', to: 'relationships#destroy', as: 'destroy_relationship'
  post 'relationship', to: 'relationships#create', as: 'create_relationship'

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
