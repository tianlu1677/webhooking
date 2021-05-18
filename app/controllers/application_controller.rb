class ApplicationController < ActionController::Base
  include Clearance::Controller
  include Pagy::Backend
  before_action :auth_current_account
  after_action { pagy_headers_merge(@pagy) if @pagy }
  helper_method :current_account

  def auth_current_account
    if signed_in?
      @current_account ||= current_user.account
    end
  end

  def current_account
    if signed_in?
      @current_account ||= current_user.account
    end
  end

end
