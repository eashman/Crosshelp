# frozen_string_literal: true

Raven.configure do |config|
  config.environments = %w[staging production]
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
  config.timeout = 10
  config.open_timeout = 10
  config.async = ->(event) { SentryJob.perform_later(event.to_hash) }
  config.silence_ready = true
  config.release = File.read(Rails.root.join('.mina_git_revision').to_s) if Rails.env.production? || Rails.env.staging?
end
