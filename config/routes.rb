Rails.application.routes.draw do

  # ERR MSG... so salty
  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

  get 'errors/not_found'

  get 'errors/internal_server_error'

  if Rails.env.production?
   get '404', :to => 'application#page_not_found'
  end

  resources :rewards
    resources :chores
    root 'welcome#index'

    get '/signup' => 'users#_new'
    resources :users
    resources :newsfeeds
    resources :groups
    resources :memberships
    resources :group_invites
    resources :chore_requests

    #get '/login' => 'sessions#_new'
    #post '/login' => 'sessions#create'

    get '/' => 'welcome#new'
    post '/' => 'welcome#create'

    # ghetto logout
    delete '/logout' => 'sessions#destroy'
    get '/logout' => 'sessions#destroy'

    get '/newsfeed/:id' => 'newsfeed#show'


    get '/groups' => 'groups#index'
    get '/groups/:id/remove_member/' => 'groups#remove_member', :as => 'remove_group_member'
    put '/groups/:id/add_member/' => 'groups#add_member', :as => 'add_group_member'
    post '/groups/:id/assign_chore/' => 'chores#assign', :as => 'assign_chore'
    get '/groups/:id/rewards' => 'groups#rewards', :as => 'group_rewards'

    # For group invites
    post '/groups/:id/invite/' => 'group_invites#create', :as => 'invite_member'
    #post '/groups/:id/request/' => 'chore_requests#create', :as => 'chore_request'

    get '/chores' => 'chores#index', :as => 'chore_page'
    get 'chores/:id/completion' => 'chores#completion', :as => 'chore_complete'
    post 'chores/destroy_all_completed' => 'chores#destroy_all_completed', :as => 'destroy_all_completed'

    resources :profile, only: [:edit, :show]
    get '/profile/:id' => 'profile#show'
    get '/edit_profile/' => 'profile#edit'

    get '/main' => 'hub#index', :as => 'main'

    get '/chores' => 'chores#index'
    get '/rewards/:id/purchase' => 'rewards#purchase', :as => 'purchase_reward'


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
