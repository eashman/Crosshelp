# frozen_string_literal: true

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{Settings.redis.host}:#{Settings.redis.port}/3" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{Settings.redis.host}:#{Settings.redis.port}/3" }
end
