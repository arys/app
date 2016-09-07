Rails.application.routes.draw do
  devise_for :users
  resources  :games
  resources  :subjects
  resources  :questions

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#index'

  get 'pages/profile'

  # Example of regular route:
  get 'my_games' => 'games#my'
  get 'invitations' => 'games#invitations'
  post 'games/:id/change_subject' => 'games#change_subject'
  post 'games/:id/valid' => 'games#valid'
  post 'games/:id/valid_quiz2' => 'games#valid_quiz2'
  get 'games/:id/wait' => 'games#wait'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  get 'profile' => 'pages#profile'
  
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
