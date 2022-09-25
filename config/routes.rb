# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, ->(user) { user.has_role?('admin') } do
    mount Sidekiq::Web => 'admin/sidekiq'
  end

  root 'pages#home'

  resources :samples do
    resources :measurments
  end

  resources :experiments

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :users, only: ['show']
end
