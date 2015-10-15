Rails.application.routes.draw do

  get 'inappropriate_products/index'

  get 'feedback/create'

  get 'feedback/destroy'

  get 'feedback_controller/create'

  get 'feedback_controller/destroy'

  get 'orders/index'

  root 'products#index'

  resources :products
  resources :orders

  get 'products/new'

  get 'products/index'

  get 'products/edit'

  get 'products/show'

  devise_for :users

  match 'orders/:id/increment_quantity' => 'orders#increment_quantity', as: :orders_increment_quantity, via: [:get]
  match 'orders/:id/decrement_quantity' => 'orders#decrement_quantity', as: :orders_decrement_quantity, via: [:get]
  match 'orders/:id/delete_all' => 'orders#delete_all', as: :orders_delete_all, via: [:get]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
