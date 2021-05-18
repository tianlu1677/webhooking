module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_account_token

    def connect
      self.current_account_token = User.find_by_remember_token cookies[:remember_token]
      if self.current_user.nil?
        reject_unauthorized_connection
      end
    end
  end
end
