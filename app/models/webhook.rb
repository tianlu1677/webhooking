# frozen_string_literal: true

# == Schema Information
#
# Table name: webhooks
#
#  id                :bigint           not null, primary key
#  uuid              :string
#  receive_email     :string
#  expired_at        :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer
#  resp_code         :integer          default(200)
#  resp_body         :string           default("")
#  resp_content_type :string           default("text/plain")
#  cors_enabled      :boolean          default(TRUE)
#  script_content    :text
#  short             :string
#
class Webhook < ApplicationRecord
  has_many :requests
  has_many :custom_actions, -> { order(position: :asc) }
  has_many :agents
  
  belongs_to :user, optional: true

  validates :uuid, presence: true, uniqueness: true
  validates :short, length: { minimum: 4, maximum: 50 }, uniqueness: true, allow_blank: true

before_validation :set_uuid

  def request_url
    "#{ENV.fetch('WEBSITE_URL', nil)}/r/#{short || uuid}"
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[custom_actions requests user]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[cors_enabled created_at expired_at id receive_email resp_body resp_code resp_content_type script_content updated_at user_id uuid webhook_token]
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

  private

def set_uuid
    self.uuid = SecureRandom.uuid.gsub('-', '')
  end

  class << self
    def fetch(short_or_uuid)
      where('uuid = ? OR short = ?', short_or_uuid, short_or_uuid).first
    end
  end
end
