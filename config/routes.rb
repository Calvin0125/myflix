Rails.application.routes.draw do
  get 'home', to: 'videos#index'
  get 'video/:id', to: 'videos#show', as: 'show_video'
  get 'category/:id', to: 'categories#show', as: 'show_category'
end
