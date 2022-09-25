# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  config.after_initialize do
    Bullet.enable = false
    Bullet.sentry = false
    Bullet.alert = true
    Bullet.bullet_logger = true
    Bullet.console = true
    Bullet.rails_logger = true
    Bullet.add_footer = true
    Bullet.skip_html_injection = false
  end

  config.cache_classes = false
  config.eager_load = false

  config.consider_all_requests_local = true
  config.server_timing = true

  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  config.active_support.deprecation = :log
  config.active_support.disallowed_deprecation = :raise
  config.active_support.disallowed_deprecation_warnings = []

  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true

  config.assets.quiet = true

  # setup sidekiq logger to work with semantic logger
  config.semantic_logger.add_appender(io: $stdout, formatter: :color) if Sidekiq.server?

  config.rails_semantic_logger.semantic = true
  config.rails_semantic_logger.started    = false
  config.rails_semantic_logger.processing = true
  config.rails_semantic_logger.rendered   = false
  config.log_level = :info
  config.rails_semantic_logger.quiet_assets = true
  config.rails_semantic_logger.ap_options = { multiline: true }
  config.rails_semantic_logger.format = :color
  config.log_tags = nil

  # rack livereload
  config.middleware.use(Rack::LiveReload, host: 'localhost', source: :vendored)
end
