# frozen_string_literal: true

class RequestsController < ApplicationController
  def show
    @request = Request.find_by!(uuid: params[:uuid])
  end

  def custom_action_logs
    @request = Request.find_by!(uuid: params[:id])
    @webhook = @request.webhook
    @custom_action_logs = @request.custom_action_logs
  end
end
