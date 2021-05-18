class WebhooksController < ApplicationController
  before_action :set_webhook, only: [:show, :clear_backpacks]
  def index
    @webhooks = Webhook.all
  end

  def show
    # @webhook = BuildWebhookService.new(current_user, cookies).find_or_create!
    if @webhook.nil?
      return redirect_to root_path
    end

    @backpacks = @webhook.backpacks.order('id desc')
    @current_backpack = Backpack.find_by(uuid: params[:backpack_id]) || @backpacks.first
  end

  # 清除底下所有的请求
  def clear_backpacks
    @webhook.backpacks.destroy_all
    redirect_to webhook_path(@webhook.uuid)
  end
  # 新建webhook
  def reset
    cookies.encrypted['webhook_token'] = ''
    @webhook = BuildWebhookService.new(current_user, cookies)
    redirect_to webhook_path(@webhook.uuid)
  end

  private

  def set_webhook
    @webhook = BuildWebhookService.new(current_user, cookies).find_or_create!
  end
end