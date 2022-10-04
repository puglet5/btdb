# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, ->(user) { user.has_role?('admin') } do
    mount Sidekiq::Web => 'admin/sidekiq'
  end

  root 'pages#home'

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
end
