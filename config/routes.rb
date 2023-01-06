Rails.application.routes.draw do
  post 'auth', to: 'auth#create'
  resources :users
  resources :brands, only: %i[show create index]
  resources :categories, only: %i[show create index]
  resources :products, only: %i[show index create]
  resources :carts, only: %i[create index] do
    resources :cart_items, as: :items
  end
  resources :variants, only: %i[index]
  resources :sku, only: %i[index create], as: :sku
end
