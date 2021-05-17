class AccountTokensController < ApplicationController
  def index
    @account_tokens = AccountToken.all
  end

  def show
    @account_token = AccountToken.find_by_id(params[:id])
    @account = @account_token.account
    @backpacks = @account_token.backpacks
  end

  private
end