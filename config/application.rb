# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WebHookKing
  class Application < Rails::Application
    config.load_defaults 6.0

    config.active_record.default_timezone = :local
    config.time_zone = 'Beijing'
    config.i18n.available_locales = %i[zh-CN en]
    config.i18n.default_locale = 'en'

    config.generators do |g|
      g.assets false
      g.helper false
      g.serializer false
      g.jbuilder false
      g.template_engine :slim
      g.test_framework :rspec,
                       fixtures: true,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       request_specs: false,
                       integrate_specs: false
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end

    # config.cache_store = [:redis_cache_store, {
    #   host: ENV['CACHE_REDIS_HOST'],
    #   port: ENV['CACHE_REDIS_PORT'],
    #   db: ENV['CACHE_REDIS_DB'],
    #   namespace: 'cache',
    #   expire_after: 3.days
    # }]
  end
end
