AstronomWeb::Application.routes.draw do

    resources :meals, :foods, :astronauts

    get 'inventory' => 'inventory#inventory'

    get '/day_snapshots/:name',
        to: 'snapshots#show',
        defaults: {
          end_time:   Time.now.to_s,
          start_time: (Time.now - 1.day).to_s
        }

    get '/week_snapshots/:name',
        to: 'snapshots#show',
        defaults: {
          end_time:   Time.now.to_s,
          start_time: (Time.now - 1.week).to_s,
          interval_in_minutes: 15
        }

    get '/snapshots/:id',
        to: 'snapshots#show'

    get '/review' => "static#review"
    root 'static#landing'
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
