# frozen_string_literal: true

# == Schema Information
#
# Table name: webhooks
#
#  id                :bigint           not null, primary key
#  uuid              :string
#  receive_email     :string
#  expired_at        :datetime
#  user_id        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  webhook_token     :string
#  user_id           :integer
#  resp_code         :integer          default(200)
#  resp_body         :string           default("")
#  resp_content_type :string           default("text/plain")
#  cors_enabled      :boolean          default(TRUE)
#  script_content    :text
#
class Webhook < ApplicationRecord
  belongs_to :user, optional: true

  has_many :requests
  has_many :custom_actions, -> { order(position: :asc) }

  before_create :set_init_data

  def set_init_data
    self.uuid = SecureRandom.uuid.gsub('-', '')
  end

  def request_url
    "#{ENV.fetch('WEBSITE_URL', nil)}/r/#{uuid}"
  end

  def self.ransackable_associations(auth_object = nil)
    ["custom_actions", "requests", "user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["cors_enabled", "created_at", "expired_at", "id", "receive_email", "resp_body", "resp_code", "resp_content_type", "script_content", "updated_at", "user_id", "uuid", "webhook_token"]
  end

  def build_response_body(request)
    template = Liquid::Template.parse(resp_body)
    template.render 'request' => request.default_template_params
  rescue StandardError
    '解析语法错误'
  end

  def default_template_param_keys(request = nil)
    request ||= requests.order('created_at desc').first
    return request.default_template_param_keys unless request.nil?

    [
      'request.uuid',
      'request.ip',
      'request.hostname',
      'request.method',
      'request.user_agent',
      'request.referer',
      'request.headers',
      'request.status_code'
    ]
  end

  class << self
    def find_by_id_or_uuid(id)
      where('uuid = ? OR id = ?', id.to_s, id.to_i).first
    end
  end
end
