# frozen_string_literal: true

Sidekiq::Extensions.enable_delay!
Sidekiq.default_worker_options = { 'backtrace' => true }

redis_url = ENV['JOB_REDIS_URL']
Sidekiq.configure_server do |config|
  config.redis = { url: redis_url }
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url }
end

schedule_file = 'config/sidekiq_schedule.yml'

Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file) if File.exist?(schedule_file) && Sidekiq.server?

# Sidekiq::Web.use Rack::Auth::Basic do |username, password|
#   [username, password] == ['good', 'today']
# end
