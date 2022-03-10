Rails.application.routes.draw do
  post 'auth', to: 'auth#create'
  resources :users
  resources :brands, only: %i[create index]
  resources :categories, only: %i[create index]
  resources :products, only: %i[show index create]
end
