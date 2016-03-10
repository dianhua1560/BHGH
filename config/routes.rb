Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
   get '/' => 'events#index'
   
   # authentication 
  get "/auth/google_oauth2/callback", to: "auth#google_callback"
  get "/auth/logout", to: "auth#logout"
  
  # Events
  get '/events' => 'events#index'
  get '/events/show/:id' => 'events#show', as: 'event'
  get '/events/new' => 'events#new', as: 'new_event'
  get '/events/edit/:id' => 'events#edit', as: 'edit_event'
  post '/events/update' => 'events#update', as: 'update_event'
  get '/events/admin' => 'events#admin', as: 'events_admin'
  get '/events/delete' => 'events#delete', as: 'delete_event'
  get 'events/respond' => 'events#respond', as: 'respond_to_event'
  get 'events/delete_response' => 'events#delete_response', as: 'delete_event_response'
  
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
