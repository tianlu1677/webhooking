class Admin::ApplicationController < ApplicationController
  layout 'admin'
  include Admin::ResourceContent
  include Pundit
  include Pagy::Backend  

  after_action { pagy_headers_merge(@pagy) if @pagy }
  
  protect_from_forgery
  before_action :require_login
  helper_method :attributes, :resource, :resource_class, :show_attributes
end