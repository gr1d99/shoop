Rails.application.routes.draw do
  resources :users
  resources :brands, only: %i[create index]
  resources :products, only: %i[index create]
end
