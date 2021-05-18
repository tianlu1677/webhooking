class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:left_list_item]

  before_action :set_webhook, only: [:show, :left_list_item]
  def index
    @webhooks = Webhook.all
  end

  def show
    if @webhook.nil?
      return redirect_to root_path
    end

    @backpacks = @webhook.backpacks.order('id desc')
    @current_backpack = Backpack.find_by(uuid: params[:backpack_id]) || @backpacks.first
  end

  def left_list_item
    @backpack = @webhook.backpacks.find params[:backpack_id]
    @current_backpack
  end

  private

  def set_webhook
    if fetch_current_user
      model = current_user.webhooks.find_by_id_or_uuid params[:id]
      cookies.encrypted['webhook_token'] = model.webhook_token
    end
    @webhook = Webhook.find_by_webhook_token cookies.encrypted['webhook_token']
  end

  def fetch_current_user
    nil
  end
end