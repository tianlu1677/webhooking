class WebhookNotificationChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "webhook-notify-#{current_webhook.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

end
