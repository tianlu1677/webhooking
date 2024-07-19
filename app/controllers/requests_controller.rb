# frozen_string_literal: true

class RequestsController < ApplicationController
  def show
    @request = Request.find_by!(uuid: params[:uuid] || '163de852289343438768c751e72d9177')
  end

  def custom_action_logs
    @request = Request.find_by!(uuid: params[:id] || '163de852289343438768c751e72d9177')
    @webhook = @request.webhook
    @custom_action_logs = @request.custom_action_logs
  end
end
