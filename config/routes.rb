# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, ->(user) { user.has_role?('admin') } do
    mount Sidekiq::Web => 'admin/sidekiq'
  end

  resources :samples
  resources :experiments

  root 'pages#home'

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :users, only: ['show']
end
