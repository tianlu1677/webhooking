# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_webhook

    def connect
      self.current_webhook = Webhook.find_by(uuid: cookies.encrypted['webhook_uuid'])
      reject_unauthorized_connection if current_webhook.nil?
    end
  end
end
