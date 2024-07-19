# frozen_string_literal: true

# password = ENV['CACHE_REDIS_PASSWORD']
$redis = Redis.new(url: ENV['REDIS_URL'])
# Redis::Objects.redis = $redis
