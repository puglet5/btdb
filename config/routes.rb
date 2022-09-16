# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
end
