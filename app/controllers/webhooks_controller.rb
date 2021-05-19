class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:left_list_item]
  before_action :set_webhook_by_params, only: [:show, :clear_backpacks, :left_list_item, :update]

  def show
    if current_user
      @webhook = Webhook.where(user_id: current_user.id).find_by_id_or_uuid(params[:id])
      set_cookie_webhook_token(@webhook.webhook_token) if @webhook.present?
    else
      @webhook = Webhook.where(webhook_token: cookie_webhook_token).find_by_id_or_uuid(params[:id])
    end

    if @webhook.nil?
      return redirect_to root_path
    end

    @backpacks = @webhook.backpacks.order('id desc')
    @current_backpack = Backpack.find_by(uuid: params[:backpack_id]) || @backpacks.first
  end

  def update
    @webhook.update(params.require(:webhook).permit(:resp_code, :resp_content_type, :resp_body))
    redirect_to "/webhooks/#{@webhook.uuid}"
  end

  # 清除底下所有的请求
  def clear_backpacks
    @webhook.backpacks.destroy_all
    redirect_to webhook_path(@webhook.uuid)
  end
  # 新建webhook
  def reset
    @webhook = BuildWebhookService.new(current_user, '').create!
    set_cookie_webhook_token(@webhook.webhook_token) if @webhook.present?
    redirect_to webhook_path(@webhook)
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