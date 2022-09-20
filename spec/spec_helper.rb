# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

require 'shoulda/matchers'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:each, type: :request) do
    host! '127.0.0.1:3000'
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
