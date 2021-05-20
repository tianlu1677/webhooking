class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:left_list_item]
  before_action :set_webhook_by_params, only: [:show, :clear_backpacks, :left_list_item, :update, :run_script]

  def show
    if @webhook.nil?
      return redirect_to not_found_webhooks_path
    end

    @backpacks = @webhook.backpacks.order('id desc')
    @current_backpack = Backpack.find_by(uuid: params[:backpack_id]) || @backpacks.first
  end

  def update
    @webhook.update(params.require(:webhook).permit(:resp_code, :resp_content_type, :resp_body, :cors_enabled, :script_content))
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
    set_cookie_webhook_token(@webhook.webhook_token)
    redirect_to webhook_path(@webhook)
  end

  def left_list_item
    @backpack = @webhook.backpacks.find params[:backpack_id]
    @current_backpack
  end

  def run_script    
    content = params[:content] || @webhook.script_content
    context = MiniRacer::Context.new
    answer = context.eval(content)
    render json: { answer: answer}
  rescue MiniRacer::RuntimeError => e
    render json: { jserror: e }
  rescue => e
    render json: { error: e} 
  end

  private

  def set_webhook_by_params
    if current_user
      @webhook = Webhook.where(user_id: current_user.id).find_by_id_or_uuid(params[:id])
      set_cookie_webhook_token(@webhook.webhook_token) if @webhook.present?
    else
      @webhook = Webhook.where(webhook_token: cookie_webhook_token).find_by_id_or_uuid(params[:id])
    end
  end
end