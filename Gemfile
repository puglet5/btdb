# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'active_model_serializers', '~> 0.10.13'
gem 'acts_as_favoritor', '~> 6.0'
gem 'amazing_print', '~> 1.4'
gem 'ar_transaction_changes', '~> 1.1'
gem 'bootsnap', require: false
gem 'cssbundling-rails'
gem 'devise', '~> 4.8', '>= 4.8.1'
gem 'doorkeeper', '~> 5.6'
gem 'dotenv-rails', '~> 2.8'
gem 'faraday', '~> 2.7'
gem 'has_scope', '~> 0.8.0'
gem 'hotwire-livereload', '~> 1.3'
gem 'image_processing', '~> 1.12', '>= 1.12.1'
gem 'jsbundling-rails'
gem 'ledermann-rails-settings', '~> 2.5'
gem 'loaf', '~> 0.10.0'
gem 'mini_magick', '~> 4.11' # image processing
gem 'pagy', '~> 6.0' # pagination
gem 'pg', '~> 1.1'
gem 'propshaft', '~> 0.6' # asset delivery
gem 'puma', '~> 6.0'
gem 'pundit', '~> 2.2'
gem 'rails', '~> 7.1.2'
gem 'ransack', '~> 4.1' # object-based searching
gem 'redis', '~> 5.0'
gem 'rolify', '~> 6.0' # user roles
gem 'rswag', '~> 2.6'
gem 'sidekiq', '~> 7.1'
gem 'simple_form', '~> 5.1' # form helpers
gem 'stimulus-rails', '~> 1.1'
gem 'turbo-rails', '~> 1.1'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'view_component', '~> 3.8'

gem 'client_side_validations', '~> 22.0'
gem 'client_side_validations-simple_form', '~> 16.0'

group :development, :test do
  gem 'better_errors', '~> 2.9'
  gem 'binding_of_caller', '~> 1.0' # for better_errors
  gem 'database_cleaner-active_record'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 3.0'
  gem 'rspec-rails', '~> 6.0'
end

group :development do
  gem 'active_record_doctor', '~> 1.10'
  gem 'annotate', '~> 3.2' # db schema annotations for models and tests
  gem 'brakeman', '~> 6.0'
  gem 'bullet', '~> 7.0', '>= 7.0.3' # detect ineffective db queries
  gem 'bundler-audit', '~> 0.9.1'
  gem 'foreman', '~> 0.87.2'
  gem 'fuubar', '~> 2.5'
  gem 'htmlbeautifier' # erb formatter
  gem 'memory_profiler' # For memory profiling
  gem 'rack-mini-profiler', '~> 3.0'
  gem 'rails-erd' # generate er diagrams
  gem 'rubocop', '~> 1.35', '>= 1.35.1', require: false
  gem 'rubocop-performance', '~> 1.14', '>= 1.14.3', require: false
  gem 'rubocop-rails', '~> 2.15', '>= 2.15.2', require: false
  gem 'web-console'
end

group :test do
  gem 'pundit-matchers', '~> 3.1' # policy matchers
  gem 'shoulda-matchers', '~> 5.1' # rails matchers for common tasks
  gem 'simplecov', '~> 0.22' # code coverage reports
end
