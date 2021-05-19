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
#  headers        :jsonb
#  status_code    :integer
#  account_id     :integer
#  token_uuid     :string
#  webhook_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  content_length :integer          default(0)
#  query_params   :jsonb
#  form_params    :jsonb
#  content_type   :string
#  media_type     :string
#  raw_content    :text
#
class Backpack < ApplicationRecord
  belongs_to :account, optional: true
  belongs_to :webhook

  before_create :set_init_data
  after_create :send_websocket_notification

  has_many_attached :files

  def set_init_data
    self.uuid = SecureRandom.uuid.gsub('-', '')
    self.token_uuid = webhook.uuid
  end

  def send_websocket_notification
    ActionCable.server.broadcast("webhook-notify-#{webhook.id}", {webhook_id: webhook.id, backpack_id: id})
  end

  def default_template_param_keys
    build_template_keys
  end

  def default_template_params
    build_info.with_indifferent_access
  end

  def json_params
    return JSON.parse(raw_content) if content_type == 'application/json'
  rescue
    {}
  end

  private
  def build_info
    {
      uuid: uuid,
      ip: ip,
      hostname: hostname,
      user_agent: user_agent,
      referer: referer,
      headers: headers,
      status_code: status_code,
      query: query_params,
      form: form_params,
      json: json_params
    }
  end

  def build_template_keys
    dict = build_info
    keys = []
    search = dict
    add_key_to_keys(search, keys)
    keys
  end

  def add_key_to_keys(search, answer, prefix = 'request')
    if search.is_a? Hash
      search.each do |key, value|
        answer << "#{prefix}.#{key}"
        add_key_to_keys(value, answer, "#{prefix}.#{key}")
      end
    else
    end
  end
end
