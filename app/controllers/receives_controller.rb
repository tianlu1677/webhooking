# frozen_string_literal: true

class ReceivesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_webhook

  def create
    webhook_request = TrackService.execute(@webhook, request)
    if @webhook.redirect_url.present?
      return redirect_to @webhook.redirect_url, status: 302, allow_other_host: true
    end

    response_body = @webhook.build_response_body(webhook_request)
    if response_body.blank?
      render body: 'Successfully processed webhook request without a custom response body', status: 200
    else
      render body: @webhook.build_response_body(webhook_request), content_type: @webhook.resp_content_type, status: @webhook.resp_code
    end
  end

  private

  def find_webhook
    short_or_uuid = params[:request_token]
    @webhook = Webhook.fetch(short_or_uuid)

    redirect_to not_found_webhooks_path if @webhook.blank?
  end
end
