module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_webhook

    def connect
      self.current_webhook = User.find_by_remember_token cookies[:remember_token]
      if self.current_user.nil?
        reject_unauthorized_connection
      end
    end
  end
end
