class Admin::ApplicationController < ApplicationController
  layout 'admin'
  include Admin::ResourceContent
  include Pundit
  include Pagy::Backend

  after_action { pagy_headers_merge(@pagy) if @pagy }

  protect_from_forgery
  before_action :require_login
  before_action :auth_admin_role!

  helper_method :attributes, :resource, :resource_class, :show_attributes


  def auth_admin_role!
    unless current_user.is_admin?
      sign_out
      redirect_to sign_in_path, notice: "你当前没有管理员权限！"
    end
  end
end