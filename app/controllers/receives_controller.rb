# frozen_string_literal: true

class ReceivesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :extrack_token

  def create
    webhook_request = TrackService.new(@webhook, request).do!
    render body: @webhook.build_response_body(webhook_request), content_type: @webhook.resp_content_type, status: @webhook.resp_code
  end

  private

  def extrack_token
    short_or_uuid = params[:request_token]
    @webhook = Webhook.fetch(short_or_uuid)
  end
end
