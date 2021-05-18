class AccountsController < ApplicationController
  # skip_before_action :verify_authenticity_token

  def index
    @accounts = Account.all
  end

  def create
  end

  def show
    @account = Account.find(params[:id])
    @current_token = @account.webhooks.first
    @backpacks = @current_token.backpacks
  end

  private
end
