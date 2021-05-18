class AccountTokensController < ApplicationController
  def index
    @account_tokens = AccountToken.all
  end

  def show
    if fetch_current_user
      model = current_user.access_tokens.find_by_id_or_uuid params[:id]
      cookies.encrypted['webhook_token'] = model.webhook_token
    end
    @account_token = AccountToken.find_by_webhook_token cookies.encrypted['webhook_token']
    if @account_token.nil?
      return redirect_to 'xxx'
    end

    @backpacks = @account_token.backpacks.order('id desc')
    @current_backpack = Backpack.find_by(uuid: params[:backpack_id]) || @backpacks.first
  end

  private

  def fetch_current_user
    nil
  end
end