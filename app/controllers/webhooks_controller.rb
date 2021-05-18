class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:left_list_item]
  before_action :set_webhook_by_params, only: [:clear_backpacks, :show]

  def show
    set_cookie_webhook_token(@webhook.webhook_token) if @webhook.present?
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
    @webhook = BuildWebhookService.new(current_user, '').find_or_create!
    set_cookie_webhook_token(@webhook.webhook_token) if @webhook.present?
    redirect_to webhook_path(@webhook.uuid)
  end

  def left_list_item
    @webhook = BuildWebhookService.new(current_user, cookie_webhook_token).find!
    @backpack = @webhook.backpacks.find params[:backpack_id]
    @current_backpack
  end

  private

  def set_webhook_by_params
    @webhook = BuildWebhookService.new(current_user, params[:id]).find!
  end

end