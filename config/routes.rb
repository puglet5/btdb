# frozen_string_literal: true

Rails.application.routes.draw do
  concern :attachment_purgeable do
    member do
      delete :purge_attachment
    end
  end

  resources :samples, concerns: :attachment_purgeable
  resources :experiments, concerns: :attachment_purgeable
  root 'pages#home'
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :users, only: ['show']
end
