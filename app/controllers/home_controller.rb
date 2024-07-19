# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    webhook = BuildWebhookService.new(current_user, cookie_webhook_token).find_or_create!
    setup_cookie_webhook_token(webhook.webhook_token)
    redirect_to webhook_path(webhook.uuid)
  end
end
