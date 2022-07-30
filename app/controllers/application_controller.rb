# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Clearance::Controller
  include Pagy::Backend
  before_action :auth_current_account
  after_action { pagy_headers_merge(@pagy) if @pagy }
  helper_method :current_account

  def auth_current_account
    @current_account ||= current_user.account if signed_in?
  end

  def current_account
    @current_account ||= current_user.account if signed_in?
  end

  def cookie_webhook_token
    cookies.encrypted['webhook_token'].presence
  end

  def set_cookie_webhook_token(value)
    # byebug
    cookies.encrypted['webhook_token'] = value
  end
end
