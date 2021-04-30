require 'sidekiq/web'
require 'sidekiq/cron/web'


Rails.application.routes.draw do
  mount Sidekiq::Web => '/admin/sidekiq'
  mount PgHero::Engine, at: '/admin/pghero'

  resources :passwords, controller: 'clearance/passwords', only: %i[create new]
  resource :session, controller: 'clearance/sessions'#, only: [:create]

  resources :users, controller: 'clearance/users', only: [:create] do
    resource :password,
             controller: 'clearance/passwords',
             only: %i[create edit update]
  end

  # get '/sign_in' => 'clearance/sessions#new', as: 'sign_in'
  # delete '/sign_out' => 'clearance/sessions#destroy', as: 'sign_out'

  root 'home#index'

  # 管理后台
  namespace :admin do
    root 'home#index'
    resources :operation_logs
    resources :users
  end
end
