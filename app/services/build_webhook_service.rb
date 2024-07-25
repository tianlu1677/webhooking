# frozen_string_literal: true

class BuildWebhookService
  attr_accessor :user, :short_or_uuid, :opts

  def initialize(user = nil, short_or_uuid = nil)
    @user = user
    @short_or_uuid = short_or_uuid
  end

  def find_or_create!
    if short_or_uuid.blank? || (webhook = find!).blank?
      webhook = create!
    end
    webhook
  end

  def create!
    Webhook.create(user_id: @user&.id)
  end

  def find!
    Webhook.where(user_id: @user&.id).fetch(short_or_uuid)
  end
end
