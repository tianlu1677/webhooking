# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # include Clearance::Controller
  include Pagy::Backend

  after_action { pagy_headers_merge(@pagy) if @pagy }

  def cookie_webhook_token
    cookies.encrypted['webhook_token'].presence
  end

  def setup_cookie_webhook_token(value)
    cookies.encrypted['webhook_token'] = value
  end
end
