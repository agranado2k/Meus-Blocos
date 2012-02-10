Carnaval2012::Application.routes.draw do
  get "sessions/create"

  get "sessions/failure"

  get "sessions/destroy"

  get "page/auth"

  get "page/home"

  get "page/blocos"

  get "page/bloco"

  get "page/friends"

  get "page/maps"

  get "page/about"

  get "page/schedule"

  root :to => "page#home"
  match '/', :to => 'page#home'
  match '/home/:id', :to => 'page#home'
  match '/home/', :to => 'page#home'
  match '/friends', :to => 'page#friends'
  match '/auth', :to => 'page#auth'
  match '/map/:bloco_id', :to => 'page#maps'
  match '/about', :to => 'page#about'
  match '/blocos', :to => 'page#blocos'
  match '/bloco/:id', :to => 'page#bloco'
  match '/join/:user_id/:bloco_id', :to => 'page#join_user_and_bloco'
  match '/disconnect/:user_id/:bloco_id', :to => 'page#disconnect_user_and_bloco'

  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
