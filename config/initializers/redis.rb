
password = ENV['CACHE_REDIS_PASSWORD']
$redis = Redis.new(host: ENV['CACHE_REDIS_HOST'], port: ENV['CACHE_REDIS_PORT'], db: ENV['CACHE_REDIS_DB'])
Redis::Objects.redis = $redis