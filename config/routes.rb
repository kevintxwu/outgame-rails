Rails.application.routes.draw do

  resources 'events'
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  match '/signup', to: 'users#new',  via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'get', via: 'delete'

  get 'template/index', :path => 'template'
  get 'template/new'
  get 'template/show'
  get 'template/edit'

  get 'mockup/index', :path => 'mockup-login'
  get 'mockup/new', :path => 'mockup-new-event'
  get 'mockup/events', :path => 'mockup-events'
  get 'mockup/info', :path => 'mockup-event-info'
  get 'mockup/checkin', :path => 'mockup-event-checkin'
  get 'mockup/brackets', :path => 'mockup-event-brackets'
  get 'mockup/summary', :path => 'mockup-event-summary'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'sessions#new'#'mockup#index' 

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
