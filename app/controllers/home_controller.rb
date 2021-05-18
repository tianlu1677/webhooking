class HomeController < ApplicationController

  def index
    find_or_create_webhook
  end

  private

  def find_or_create_webhook
    if cookies.encrypted['webhook_token'].nil?
      cookies.encrypted['webhook_token'] = SecureRandom.hex
    end

    webhook = Webhook.find_or_create_by(user_id: fetch_user_id, webhook_token: cookies.encrypted['webhook_token'])

    redirect_to webhook_path(webhook.uuid)
  end

  private
  def fetch_user_id
    return nil
  end

end
