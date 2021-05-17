class HomeController < ApplicationController

  def index
    find_or_create_account_token
  end

  private

  def find_or_create_account_token
    anonymous_token = request.cookies['anonymous_account_token']
    account_token = AccountToken.find_by(uuid: anonymous_token)
    if account_token.blank?
      account_token = set_anonymous_account_token
      redirect_to account_token_path(account_token)
    else
      redirect_to account_token_path(account_token)
    end
  end

  def set_anonymous_account_token
    account_token = AccountToken.create!
    response.set_cookie('anonymous_account_token', account_token.uuid)
    account_token
  end
end
