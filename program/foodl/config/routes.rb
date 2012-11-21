Foodl::Application.routes.draw do

#  get "search/index"

  resources :sessions, only: [:new, :create, :destroy]
  #resources :shopping_list

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
  root to: 'search#index'
 
  match '/about', to: 'home#about'
  match '/contact', to: 'home#contact'

  #match '/users', to: 'users#index'
  #match '/users/:id', to: 'users#show'
  match '/login', to: 'users#new'
  match '/logout', to: 'sessions#destroy', via: :delete

  match '/list', to: 'shopping_list#index'
  match '/list/add', to: 'shopping_list#create'
  match '/list/remove', to: 'shopping_list#remove'

  match '/recipes/images/:id', to: 'recipes#picture'

  match '/search', to: 'search#result'
  
  match '/favorites', to: 'favorites#index'
  match '/favorites/add/:id', to: 'favorites#add'
  match '/favorites/remove/:id', to: 'favorites#remove'

  match '/search/autocomplete/:q', to: 'search#autocomplete_food_types'
  # See how all your routes lay out with "rake routes"
  resources :users
  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
