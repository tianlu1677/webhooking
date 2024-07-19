# frozen_string_literal: true

sidekiq_redis = ENV.fetch('REDIS_URL', 'redis://127.0.0.1:6379/0')
Sidekiq.configure_server do |config|
  config.redis = { url: sidekiq_redis }
end

Sidekiq.configure_client do |config|
  config.redis = { url: sidekiq_redis }
end

# https://github.com/ondrejbartas/sidekiq-cron
schedule_file = 'config/sidekiq_cron.yml'

Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file) if File.exist?(schedule_file) && Sidekiq.server?
