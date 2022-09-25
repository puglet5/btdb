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

    config.active_storage.variant_processor = :mini_magick
    config.active_storage.analyzers.delete ActiveStorage::Analyzer::ImageAnalyzer
    config.active_storage.analyzers.append ActiveStorage::Analyzer::ImageAnalyzer::Vips
    config.active_storage.track_variants = true # used to eager load image variants

    config.action_view.image_loading = 'lazy'

    config.active_job.queue_adapter         = :sidekiq
    config.active_storage.queues.analysis   = nil
    config.active_storage.queues.purge      = nil
    config.active_storage.queues.mirror     = nil

    config.generators do |g|
      g.view_specs false
      g.helper_specs false
    end
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
