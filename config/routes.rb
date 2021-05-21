Rails.application.routes.draw do
  resources :users
  resources :brands, only: :create
end

