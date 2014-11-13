Rails.application.routes.draw do
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
  root 'stores#index'

  resources :products do 
    resources :comments, only: [:index, :create, :destroy]
  end
  resources :users do
    member do
      get :follow
      get :unfollow
      get :collect
      get :uncollect
      get :following
      get :collecting
    end
  end
  namespace :admin do
    resources :replies, only: [:create, :destroy]
    resources :products, only: [:create, :destroy, :update] do 
      member do
        get :drop_product
        get :pick_product
      end
      collection do 
        get :show_down_products
        get :show_up_products
      end
      resources :properties, only: [:create, :update, :destroy]
      resources :skucates, only: [:create, :update, :destroy]
      resources :imglists, only: [:create, :update, :destroy] do
        collection do 
          put :update_order
        end
      end
      resources :details, only: [:create, :update, :destroy]
    end
    resources :categories, only: [:create, :index, :update]
    resources :stores, only: :update
  end
  resources :categories
  resources :sessions, only: [:create, :destroy]
  resources :collecting_relationships, only: [:new, :create, :destroy]
  resources :items 
  resources :messages, only: [:index, :destroy] do 
    collection do 
      get :unreadmessages
    end
  end

  match '/search', to: 'products#search', via: 'get'
  match '/signin', to: 'sessions#create', via: 'post'
  match '/nosign_id', to: 'users#nosign_id', via: 'get'
  namespace :admin do
    match '/signin', to: 'owners#signin', via: 'post' 
  end


end

