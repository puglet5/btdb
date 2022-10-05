# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  root 'pages#home'

  authenticate :user, ->(user) { user.has_role?('admin') } do
    mount Sidekiq::Web => 'admin/sidekiq'
  end

  resources :samples do
    resources :measurments, only: %i[new edit update create destroy]
  end

  resources :experiments

  devise_for :users, path: '', path_names: { sign_in: :login, sign_out: :logout, sign_up: :register }
  resources :users, only: %i[show] do
    member do
      patch :update_settings
    end
  end

  namespace :api do
    namespace :v1 do
      resources :samples
      resources :measurments
      resources :spectra
    end
  end

  scope :api do
    scope :v1 do
      use_doorkeeper do
        skip_controllers :authorization, :authorized_applications
      end
    end
  end
end
