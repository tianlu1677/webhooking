class ReceivesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :extrack_token

  def create
    # byebug
    backpack = TrackService.new(request).do!
    render json: { status: 'ok', backpack: backpack }
  end

  private

  def extrack_token
    @token_uuid = params[:backpack_token]
    @webhook = Webhook.find_by!(uuid: @token_uuid)
  end
end
