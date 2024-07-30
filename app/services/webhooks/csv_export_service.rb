# frozen_string_literal: true

module Webhooks
  class CsvExportService
    attr_accessor :webhook, :limit

    def initialize(webhook_id, limit: 100)
      @webhook = Webhook.find(webhook_id)
      @limit = limit
    end

    def execute
      webhook.requests.order('id desc').limit(limit)
    end
  end
end
