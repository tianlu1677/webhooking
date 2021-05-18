class AccountTokensController < ApplicationController
  def index
    @account_tokens = AccountToken.all
  end

  def show
    @account_token = AccountToken.find_by_id_or_uuid(params[:id])
    @backpacks = @account_token.backpacks.order('id desc')
    @current_backpack = Backpack.find_by(uuid: params[:backpack_id]) || @backpacks.first
  end

  private
end