class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:left_list_item]
  before_action :set_webhook, only: [:show, :clear_backpacks, :left_list_item]

  def show
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

  def left_list_item
    @backpack = @webhook.backpacks.find params[:backpack_id]
    @current_backpack
  end

  private

  def set_webhook
    @webhook = BuildWebhookService.new(current_user, cookies).find_or_create!
  end

end