Rails.application.routes.draw do

  root 'hacker/user_posts#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  namespace :hacker do
   get '/search/search_all' => 'search#search_all'
   resources :users, only:[:index, :show] do
    member do
      get :following, :followers
    end
   end
   resources :relationships, only:[:create, :destroy]
   resources :user_posts, only:[:index, :create]
   resources :projects do
    member do
      get :show_users # プロジェクトにユーザーを追加するためのユーザー一覧ページ
    end
    resources :project_posts, only:[:new, :create] do
      post :comment_create, on: :member
    end
   end
   resources :thread_tables, only:[:index, :new, :create] do
    resources :responses, only:[:index, :create]
   end
   post '/projects/like/:project_id' => 'project_likes#like', as: 'project_like' #いいね！
   delete '/projects/unlike/:project_id' => 'project_likes#unlike', as: 'project_unlike' #いいね！の取り消し

   post '/projects/:id/add_project_user/:user_id' => 'projects#add_project_user', as: 'add_project_user' # プロジェクトにユーザーを追加
   delete '/projects/:id/destroy_project_user/:user_id' => 'projects#destroy_project_user', as: 'destroy_project_user' # プロジェクトからユーザーを削除 
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

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
