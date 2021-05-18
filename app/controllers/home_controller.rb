class HomeController < ApplicationController

  def index
    webhook = BuildWebhookService.new(current_user, cookies).find_or_create!
    redirect_to webhook_path(webhook.uuid)
  end

  private
end
