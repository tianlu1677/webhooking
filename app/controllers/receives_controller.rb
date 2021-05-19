class ReceivesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :extrack_token

  def create
    # binding.pry
    backpack = TrackService.new(request).do!
    render body: @webhook.build_response_body(backpack), content_type: @webhook.resp_content_type, status: @webhook.resp_code
  end

  private

  def extrack_token
    @token_uuid = params[:backpack_token]
    @webhook = Webhook.find_by!(uuid: @token_uuid)
  end
end
