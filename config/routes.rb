Rails.application.routes.draw do

  devise_for :users, skip: [:sessions, :password]
  devise_scope :user do
    resources :sessions, only: [:new, :create] do
      collection do
        delete 'destroy', as: :destroy
        get 'password_reset', as: :password_reset
      end
    end
    resources :password_resets, only: [:new, :create, :edit, :update]
  end

  ActiveAdmin.routes(self)

  resources :groups, only: [:index]
  resources :monthly_report_comments, only: [:create, :edit, :update, :destroy]

  root to: 'monthly_reports#index'

  resources :user_profiles, only: [:show, :edit, :update]
  resources 'monthly_reports', except: :destroy do
    collection do
      get 'users/:user_id', action: :user, as: :user
      get :copy
    end
  end
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
