# frozen_string_literal: true

class Clearance::UsersController < Clearance::BaseController
  if respond_to?(:before_action)
    before_action :redirect_signed_in_users, only: [:create, :new]
    skip_before_action :require_login, only: [:create, :new], raise: false
    skip_before_action :authorize, only: [:create, :new], raise: false
  else
    before_filter :redirect_signed_in_users, only: [:create, :new]
    skip_before_filter :require_login, only: [:create, :new], raise: false
    skip_before_filter :authorize, only: [:create, :new], raise: false
  end

  after_action :relation_current_webhook, only: [:create]

  def new
    @user = user_from_params
    render template: 'clearance/users/new'
  end

  def create
    @user = user_from_params

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      render template: 'clearance/users/new'
    end
  end

  private

  def relation_current_webhook
    if signed_in? && (webhook_token = cookies.encrypted['webhook_token'].presence).present?
      webhook = Webhook.find_by(webhook_token: webhook_token)
      if webhook && webhook.user_id.blank?
        webhook.update(user_id: @user.id)
      end
    end
  end

  def avoid_sign_in
    warn "[DEPRECATION] Clearance's `avoid_sign_in` before_filter is " \
         'deprecated. Use `redirect_signed_in_users` instead. ' \
         'Be sure to update any instances of `skip_before_filter :avoid_sign_in`' \
         ' or `skip_before_action :avoid_sign_in` as well'
    redirect_signed_in_users
  end

  def redirect_signed_in_users
    redirect_to Clearance.configuration.redirect_url if signed_in?
  end

  def url_after_create
    Clearance.configuration.redirect_url
  end

  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    username = user_params.delete(:username)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
    end
  end

  def user_params
    params[Clearance.configuration.user_parameter] || {}
  end
end
