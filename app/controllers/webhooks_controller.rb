class WebhooksController < ApplicationController
  def index
    @webhooks = Webhook.all
  end

  def show
    if fetch_current_user
      model = current_user.webhooks.find_by_id_or_uuid params[:id]
      cookies.encrypted['webhook_token'] = model.webhook_token
    end
    @webhook = Webhook.find_by_webhook_token cookies.encrypted['webhook_token']
    if @webhook.nil?
      return redirect_to root_path
    end

    @backpacks = @webhook.backpacks.order('id desc')
    @current_backpack = Backpack.find_by(uuid: params[:backpack_id]) || @backpacks.first
  end

  private

  def fetch_current_user
    nil
  end
end