require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  resources :custom_actions
  mount Sidekiq::Web => '/admin/sidekiq'
  mount PgHero::Engine, at: '/admin/pghero'

  resources :passwords, controller: 'clearance/passwords', only: %i[create new]
  resource :session, controller: 'clearance/sessions' # , only: [:create]

  resources :users, controller: 'clearance/users', only: [:create] do
    resource :password,
             controller: 'clearance/passwords',
             only: %i[create edit update]
  end

  # get '/sign_in' => 'clearance/sessions#new', as: 'sign_in'
  # delete '/sign_out' => 'clearance/sessions#destroy', as: 'sign_out'

  root 'home#index'

  resources :accounts
  resources :webhooks do
    member do
      post :clear_backpacks
      post :left_list_item
      post :reset
      post :run_script
      post :exec_script
    end
    collection do
      get :not_found
    end
    resources :custom_actions do
      member do
        post :sort
      end
    end
  end
  resources :backpacks

  get 'webhooks/:id/:backpack_id', to: 'webhooks#show'

  match 'r/:backpack_token', via: %i[get post patch delete put head options], to: 'receives#create'

  # 管理后台
  namespace :admin do
    root 'home#index'
    resources :operation_logs
    resources :users
    resources :backpacks
    resources :webhooks
    resources :accounts
  end
end
