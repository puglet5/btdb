# frozen_string_literal: true

require_relative 'boot'

require 'rails'

# rubocop:disable Lint/SuppressedException
%w[
  active_record/railtie
  active_storage/engine
  action_controller/railtie
  action_view/railtie
  action_mailer/railtie
  active_job/railtie
  action_text/engine
].each do |railtie|
  require railtie
rescue LoadError
end
# rubocop:enable Lint/SuppressedException

Bundler.require(*Rails.groups)

module Btdb
  class Application < Rails::Application
    config.load_defaults 7.0

    config.time_zone = 'Moscow'

    config.middleware.use Rack::Deflater
  end
end

module JSON
  def self.is_json?(json)
    case json
    when String
      return true if JSON.parse(json)
    when Hash
      return true if JSON.parse(JSON.generate(json))
    end
  rescue JSON::ParserError
    false
  end
end
