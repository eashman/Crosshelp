# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CrossBorderHelp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    # config.active_job.queue_adapter = :sidekiq
    config.time_zone = 'Beijing'
    config.cache_store = :redis_store, {
      host: Settings.redis.host,
      password: Settings.redis.password,
      port: Settings.redis.port,
      db: Settings.redis.cache,
      expires_in: Settings.redis.expires_in
    }

    config.active_job.queue_adapter = :sidekiq
    config.active_job.queue_name_prefix = Rails.env
    config.active_job.queue_name_delimiter = '_'

    config.i18n.available_locales = %i[zh-CN en ]
    config.i18n.default_locale = :"zh-CN"
    config.eager_load_paths += Dir[Rails.root.join('lib')]
    config.autoload_paths += %W[#{config.root}/app/services]
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '/api/*', headers: :any, methods: %i[get post options put delete patch]
      end
    end
  end
end
