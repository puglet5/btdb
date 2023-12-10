# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  root 'pages#home'

  authenticate :user, ->(user) { user.has_role?('admin') } do
    mount Sidekiq::Web => '/admin/sidekiq'
    mount Rswag::Ui::Engine => 'api-docs'
    mount Rswag::Api::Engine => 'api-docs'
  end

  resources :samples do
    resources :measurements, only: %i[new edit update create destroy] do
      resources :spectra do
        member do
          get :request_processing
          get :show_processing_indicator
          get :show_request_processing_button
          get :show_chart_area
        end
      end
    end
    member do
      patch :favorite
    end
  end

  resources :experiments do
    member do
      patch :favorite
    end
  end

  devise_for :users, path: '', path_names: { sign_in: :login, sign_out: :logout, sign_up: :register }
  resources :users, only: %i[show] do
    member do
      patch :update_settings
    end
  end

  namespace :api do
    namespace :v1 do
      resources :samples
      resources :measurements
      resources :spectra
    end
  end

  scope :api do
    use_doorkeeper do
      skip_controllers :authorizations, :authorized_applications
    end
  end
end
