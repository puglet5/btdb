# frozen_string_literal: true

Rails.application.routes.draw do
  resources :experiments
  root 'pages#home'
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :users, only: ['show']
end
