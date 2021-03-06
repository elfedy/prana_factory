Rails.application.routes.draw do

  get 'sessions/new'

  get 'admins/index'

  get 'admins/actions'

  get 'actions' => 'admin_pages#actions'

  root 'static_pages#inicio'
  get 'nuestros_productos'      => 'static_pages#nuestros_productos'
  get 'comprar'                 => 'static_pages#comprar'

  get 'prana_admin_login'     => 'sessions#new'
  post 'prana_admin_login'    => 'sessions#create'
  delete 'prana_admin_logout' => 'sessions#destroy'

  resources :categories do
    resources :products, only: [:new, :create, :edit, :update]
    resources :packages, only: [:new, :create, :edit, :update]
    resources :skus, only: [:index]
  end

  resources :products, only: [:destroy]
  resources :packages, only: [:destroy]
  resources :orders, only: [:destroy]
  resources :line_items, only: [:create, :destroy]
  resources :checkouts, except: [:edit]

  resources :admins, only: [:index, :new, :create, :destroy]
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
