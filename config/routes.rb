# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords'
    # omniauth_callbacks: 'users/omniauth_callbacks'
  }

  mount Sidekiq::Web => '/admin/sidekiq'
  mount PgHero::Engine, at: '/admin/pghero'

  root 'home#index'
  resources :custom_actions

  resources :users, only: [] do
    collection do
      get :webhooks
    end
  end

  resources :webhooks do
    member do
      post :clear_requests
      post :left_list_item
      post :reset
      post :run_script
    end
    collection do
      get :not_found
    end
    resources :custom_actions do
      collection do
        get :incoming_variables
      end
      member do
        post :sort
      end
      collection do
        post :exec_script
      end
    end
  end
  resources :requests do
    member do
      get :custom_action_logs
    end
  end

  get 'webhooks/:id/:request_id', to: 'webhooks#show'

  match 'r/:request_token', via: %i[get post patch delete put head options], to: 'receives#create'

  namespace :admin do
    root 'home#index'
    resources :users
    resources :requests
    resources :webhooks
  end
end
