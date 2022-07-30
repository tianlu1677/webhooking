# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '/r/*', headers: :any, methods: %i[get post patch put], if: proc { |env|
      uuid = env['PATH_INFO'].split('/').last
      model = Webhook.find_by_uuid uuid
      !!model&.cors_enabled
    }
  end
end
