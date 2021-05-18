class HomeController < ApplicationController

  def index
    find_or_create_account_token
  end

  private

  def find_or_create_account_token
    if cookies.encrypted['webhook_token'].nil?
      cookies.encrypted['webhook_token'] = SecureRandom.hex
    end

    model = AccountToken.find_or_create_by(user_id: fetch_user_id, webhook_token: cookies.encrypted['webhook_token'])

    redirect_to account_token_path(account_token)
  end

  def set_anonymous_account_token
    account_token = AccountToken.create!
    response.set_cookie('anonymous_account_token', account_token.uuid)
    account_token
  end

  private
  def fetch_user_id
    return nil
  end

end
