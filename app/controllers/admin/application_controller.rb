# frozen_string_literal: true

module Admin
  class ApplicationController < ApplicationController
    layout 'admin'
    include Admin::ResourceContent
    include Pagy::Backend
    include ActionView::RecordIdentifier

    protect_from_forgery

    after_action { pagy_headers_merge(@pagy) if @pagy }
    before_action :authenticate_user!

    before_action :auth_admin_role!

    helper_method :attributes, :resource, :resource_class, :show_attributes

    def auth_admin_role!
      return if current_user.admin?

      sign_out :user
      redirect_to user_session_path, notice: 'You dont have admin'
    end
  end
end
