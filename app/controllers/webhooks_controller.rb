# frozen_string_literal: true

class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:left_list_item]
  before_action :set_webhook_by_params, only: %i[show clear_requests left_list_item update run_script]

  def show
    return redirect_to not_found_webhooks_path if @webhook.nil?

    @requests = @webhook.requests.order('id desc')
    @current_request = Request.find_by(uuid: params[:request_id]) || @requests.first
  end

  def update
    @webhook.update(params.require(:webhook).permit(:resp_code, :resp_content_type, :resp_body, :cors_enabled, :script_content))
    redirect_to "/webhooks/#{@webhook.uuid}"
  end

  def clear_requests
    @webhook.requests.destroy_all
    redirect_to webhook_path(@webhook.uuid)
  end

  def reset
    @webhook = BuildWebhookService.new(current_user, '').create!
    setup_cookie_webhook_token(@webhook.webhook_token)
    redirect_to "/webhooks/#{@webhook.uuid}"
  end

  def left_list_item
    @request = @webhook.requests.find params[:request_id]
    @current_request
  end

  # def exec_script
  #   content = params[:content] || @webhook.script_content

  #   Capybara.default_driver = :selenium_chrome_headless # :selenium_chrome and :selenium_chrome_headless
  #   Capybara.visit('http://ohio.ce04.com')
  #   page = Capybara.page

  #   answer = page.evaluate_script(<<~JS)
  #     (function () {
  #       window.gooday = "hello";
  #       window.headers = "yes";
  #     })()
  #   JS

  #   answer = page.evaluate_script(<<~JS)
  #     (function () {
  #       #{content}
  #     })()
  #   JS
  #   render json: { answer: answer}
  # rescue Selenium::WebDriver::Error::WebDriverError => e
  #   render json: { jserror: e}
  # rescue => e
  #   render json: { error: e }
  # end

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

  def set_webhook_by_params
    if current_user
      @webhook = Webhook.where(user_id: current_user.id).find_by_id_or_uuid(params[:id])
      setup_cookie_webhook_token(@webhook.webhook_token) if @webhook.present?
    else
      @webhook = Webhook.where(webhook_token: cookie_webhook_token).find_by_id_or_uuid(params[:id])
    end
  end
end
