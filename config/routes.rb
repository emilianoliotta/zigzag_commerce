Rails.application.routes.draw do

  root 'products#index'

  post 'sales/notifications'
  get 'sales/notifications'

  get 'contact/oferta'

  get 'inappropriate_products/index'

  get 'feedback/create'
  get 'feedback/destroy'
  get 'feedback_controller/create'
  get 'feedback_controller/destroy'

  get 'orders/index'

  resources :products
  resources :orders
  resources :sales

  get 'products/new'
  get 'products/index'
  get 'products/edit'
  get 'products/show'

  devise_for :users

  match 'orders/:id/increment_quantity' => 'orders#increment_quantity', as: :orders_increment_quantity, via: [:get]
  match 'orders/:id/decrement_quantity' => 'orders#decrement_quantity', as: :orders_decrement_quantity, via: [:get]
  match 'orders/:id/delete_all' => 'orders#delete_all', as: :orders_delete_all, via: [:get]

end
