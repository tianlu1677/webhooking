# frozen_string_literal: true

class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:left_list_item]
  before_action :set_webhook, only: %i[show clear_requests left_list_item update run_script]

  def show
    return redirect_to not_found_webhooks_path if @webhook.nil?

    @requests = @webhook.requests.order('id desc').limit(100)
    @current_request = Request.find_by(uuid: params[:request_id]) || @requests.first
  end

  def update
    @webhook.update(webhook_params)
    redirect_to "/webhooks/#{@webhook.short || @webhook.uuid}"
  end

  def clear_requests
    @webhook.requests.destroy_all
    redirect_to webhook_path(@webhook.uuid)
  end

  def reset
    @webhook = BuildWebhookService.new(current_user, '').create!
    setup_cookie_webhook_token(@webhook)
    redirect_to "/webhooks/#{@webhook.uuid}"
  end

  def left_list_item
    @request = @webhook.requests.find params[:request_id]
    @current_request
  end

  def run_script
    content = params[:content] || @webhook.script_content
    context = MiniRacer::Context.new
    answer = context.eval(content)
    render json: { answer: }
  rescue MiniRacer::RuntimeError => e
    render json: { jserror: e }
  rescue StandardError => e
    render json: { error: e }
  end

  private

  def set_webhook
    if current_user
      @webhook = Webhook.where(user_id: current_user.id).fetch(params[:id])
      setup_cookie_webhook_token(@webhook) if @webhook.present?
    else
      @webhook = Webhook.fetch(params[:id])
    end
  end

  def webhook_params
    params.require(:webhook).permit(:short, :redirect_url, :resp_code, :resp_content_type, :resp_body, :cors_enabled, :script_content)
  end
end
