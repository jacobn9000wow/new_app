
FirstApp::Application.routes.draw do

  

  resources :invitations

  match '/users/create(/:token)', to: 'users#create'

  resources :users do
    member do
      get :groups	#Since both pages will be showing data, we use get to arrange for the URIs to respond to GET requests (as required by the REST convention for such pages), and the member method means that the routes respond to URIs containing the user id.
    end
  end

  resources :rooms do
    member do
      get :members
    end
  end

  
 
  get "static_pages/home"

  get "static_pages/help"

  get "static_pages/about"

  get "static_pages/contact"

  #get "rooms/new_post"

  root :to => 'static_pages#home'
  #match '/' to: 'static_pages#home'

  resources :users
  resources :posts,	only: [:new, :create, :destroy]
  resources :rooms
  resources :comments,   only: [:create, :destroy]
  resources :inclusions, only: [:create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :directinvites


  

  #match '/new_post', to: 'rooms#new_post'

  #map.connect '/new_post/:room_id', controller=>'posts', :action=> 'new' #rails 2
 
  #match '/comment/:target_post_id' => 'comments#create'
  #match '/confirm/:token', :to => 'invitation#redeem'
  #match '/new_invite/:invitation', :to => 'users#new_invite', :as => 'new_invite'
  
  post 'signinmobile' => 'sessions#create', :as => 'loginmobile'
  post 'newpostmobile' => 'posts#create'#, :as => ''
  match '/confirm/:token', :to => 'invitations#redeem', :as => 'confirm'
  match '/invitation/:token' => 'invitations#show'
  #match '/users/new_invite/:room_id' => 'users#new_invite' #should not be exposed to the web
  match '/new_post/:room_id' => 'posts#new'
  match '/new_invitation/:room_id' => 'invitations#new'
  match '/new_directinvite/:room_id' => 'directinvites#new' #<%= link_to "Invite by username", new_directinvite_path(@room.id) %>
  match '/newroom', :to => 'rooms#new'
  match '/join_room' => 'rooms#join'
  match '/newroom', to: 'rooms#new'
  match '/signup(/:token)',  to: 'users#new'	#gives named route signup_path
  match '/signup',  to: 'users#new'	#gives named route signup_path
  #match "/signup(/:token)", controller => "users", :action => "new"
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete #Note the use of via: :delete for the signout route, which indicates that it should be invoked using an HTTP DELETE request.
#Note that the routes for signin and signout are custom, but the route for creating a session is simply the default (i.e., [resource name]_path)

  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'

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
  # match ':controller(/:action(/:id))(.:format)'
end
