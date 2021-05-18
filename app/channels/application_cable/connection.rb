module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_webhook

    def connect
      self.current_webhook = Webhook.find_by_webhook_token cookies.encrypted['webhook_token']
      if self.current_webhook.nil?
        reject_unauthorized_connection
      end
    end
  end
end
