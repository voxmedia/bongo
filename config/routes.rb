Rails.application.routes.draw do
  
  resources :font_sets

  resources :projects

  # Auth Support
  get '/auth/:provider/callback' => 'sessions#create'
  get '/auth/failure'            => 'sessions#failure'
  get '/logout'                  => 'sessions#destroy', :as => :logout
  get '/login'                   => 'sessions#new',     :as => :login

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'projects#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  get 'projects/:id/details' => 'projects#details', as: :project_details
  get 'projects/:project_id/fontset/:id/details' => 'font_sets#details', as: :font_set_details
  get ':project_id/:project_slug/:id/:slug' => 'font_sets#show', as: :show_font_set, constraints: {project_id: /\d+/, id: /\d+/}

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

  resources :projects do
    resources :font_sets
  end

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
