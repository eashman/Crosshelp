# frozen_string_literal: true
redis_basic = {
  host: Settings.redis.host,
  #password: Settings.redis.password,
  port: Settings.redis.port
}

require 'connection_pool'
Redis::Objects.redis = ConnectionPool.new(size: 5, timeout: 5) { Redis.new redis_basic.merge(db: Settings.redis.object_db) }

$redis = Redis.new redis_basic.merge(db: Settings.redis.queue)
