# frozen_string_literal: true

class BackpacksController < ApplicationController
  def show
    @backpack = Backpack.find_by!(uuid: params[:uuid] || '163de852289343438768c751e72d9177')
  end

  def custom_action_logs
    @backpack = Backpack.find_by!(uuid: params[:id] || '163de852289343438768c751e72d9177')
    @webhook = @backpack.webhook
    @custom_action_logs = @backpack.custom_action_logs
  end
end
