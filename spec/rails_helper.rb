# frozen_string_literal: true

require File.expand_path('../config/environment', __dir__)
require 'spec_helper'
require 'rspec/rails'
require 'sidekiq/testing'
require 'database_cleaner/active_record'
require 'devise'
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ENV['RAILS_ENV'] ||= 'test'
abort('The Rails environment is running in production mode!') if Rails.env.production?

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

Sidekiq::Testing.fake!

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.include FactoryBot::Syntax::Methods
  config.include Devise::TestHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :feature
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Warden::Test::Helpers, type: :system
  config.include Warden::Test::Helpers, type: :request
  config.include Devise::Test::IntegrationHelpers, type: :system
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include RequestSpecHelper, type: :request
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
