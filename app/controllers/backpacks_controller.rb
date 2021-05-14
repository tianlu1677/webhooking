class BackpacksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
  end

  def show
    @backpack = Backpack.find_by!(uuid: params[:uuid] || '163de852289343438768c751e72d9177')
  end

  private
end
