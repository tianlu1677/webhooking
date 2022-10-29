# frozen_string_literal: true

# password = ENV['CACHE_REDIS_PASSWORD']
$redis = Redis.new(url: ENV['CABLE_REDIS_URL'])
Redis::Objects.redis = $redis
