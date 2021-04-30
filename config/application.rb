require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rails6TemplateWeb
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.active_record.default_timezone = :local
    config.time_zone = 'Beijing'
    config.i18n.available_locales = [:"zh-CN", :en]
    config.i18n.default_locale = :"zh-CN"

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

    config.cache_store = :redis_store, {
      host: ENV['CACHE_REDIS_HOST'],
      port: ENV['CACHE_REDIS_PORT'],
      db: ENV['CACHE_REDIS_DB'],
      namespace: 'cache',
      expire_after: 3.months
    }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
