# frozen_string_literal: true

class BuildWebhookService
  attr_accessor :user, :webhook_token, :opts
  def initialize(user = nil, webhook_token_or_uuid = nil)
    @user = user
    @webhook_token = webhook_token_or_uuid
  end

  def find_or_create!
    if webhook_token.blank? || (webhook = find!).blank?
      webhook = create!
    end
    webhook
  end

  def create!
    webhook = Webhook.create(user_id: @user&.id, webhook_token: SecureRandom.hex)
  end

  def find!
    webhook = Webhook.where(user_id: @user&.id).where('id = ? OR webhook_token = ? OR uuid = ?', webhook_token.to_i, webhook_token, webhook_token).first

    webhook
  end
end
