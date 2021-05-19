# == Schema Information
#
# Table name: backpacks
#
#  id             :bigint           not null, primary key
#  uuid           :string
#  url            :string
#  req_method     :string
#  ip             :string
#  hostname       :string
#  user_agent     :string
#  referer        :string
#  content        :text
#  headers        :jsonb
#  status_code    :integer
#  req_params     :jsonb
#  account_id     :integer
#  token_uuid     :string
#  webhook_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  content_length :integer          default(0)
#  query_params   :jsonb
#  form_params    :jsonb
#  json_params    :jsonb
#
class Backpack < ApplicationRecord
  belongs_to :account, optional: true
  belongs_to :webhook

  before_create :set_init_data
  after_create :send_websocket_notification

  def set_init_data
    self.uuid = SecureRandom.uuid.gsub('-', '')
    self.token_uuid = webhook.uuid
  end

  def send_websocket_notification
    ActionCable.server.broadcast("webhook-notify-#{webhook.id}", {webhook_id: webhook.id, backpack_id: id})
  end
end
