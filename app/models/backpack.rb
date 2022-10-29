# frozen_string_literal: true

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
#  user_id     :integer
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
  belongs_to :user, optional: true
  belongs_to :webhook
  has_many :custom_action_logs

  before_create :set_init_data
  after_commit :send_websocket_notification, only: [:create]
  after_commit :run_custom_actions, only: [:create]

  has_many_attached :files

  def set_init_data
    self.uuid = SecureRandom.uuid.gsub('-', '')
    self.token_uuid = webhook.uuid
  end

  def send_websocket_notification
    ActionCable.server.broadcast("webhook-notify-#{webhook.id}", { webhook_id: webhook.id, backpack_id: id })
  end

  def default_template_param_keys
    build_template_keys
  end

  def default_template_params
    build_info.with_indifferent_access
  end

  def json_params
    return JSON.parse(raw_content) if content_type == 'application/json'
  rescue StandardError
    {}
  end

  def content
    JSON.parse(raw_content)
  rescue StandardError
    raw_content
  end

  private

  def build_info
    {
      uuid: uuid,
      ip: ip,
      hostname: hostname,
      method: req_method,
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
    return unless search.is_a? Hash

    search.each do |key, value|
      answer << "#{prefix}.#{key}"
      add_key_to_keys(value, answer, "#{prefix}.#{key}")
    end
  end

  def run_custom_actions
    original_params = default_template_params
    params = {}
    webhook.custom_actions.order(:position).each do |custom_action|
      original_params, params = custom_action.execute original_params, params
      CustomActionLog.log!(self, custom_action, original_params: original_params, custom_params: params)
      [original_params, params]
    end
  end
end
