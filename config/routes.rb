Rails.application.routes.draw do
  get 'home', to: 'videos#index'
  get 'category/:id', to: 'categories#show', as: 'show_category'
  resources :videos, only: [:show] do
    collection do
      get 'search', to: 'videos#search'
    end
  end
end
