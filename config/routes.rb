Rails.application.routes.draw do
  post 'auth', to: 'auth#create'
  resources :users do
    resources :shipping_addresses, only: %i[create index]
  end
  resources :shipping_addresses, only: %i[update show]
  resources :brands, only: %i[show create index]
  resources :categories, only: %i[show create index]
  resources :products, only: %i[show index create]
  resources :carts, only: %i[create show index] do
    resources :cart_items, as: :items
    resources :orders, only: %i[create], shallow: true
  end
  resources :variants, only: %i[index]
  resources :sku, only: %i[index create], as: :sku
  resources :payment_methods, only: :index
  resources :orders, only: :show do
    resources :orders_payment_methods, only: :create, as: :payment_methods
  end
end
