# == Schema Information
#
# Table name: webhooks
#
#  id                :bigint           not null, primary key
#  uuid              :string
#  receive_email     :string
#  expired_at        :datetime
#  account_id        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  webhook_token     :string
#  user_id           :integer
#  resp_code         :integer          default(200)
#  resp_body         :string           default("")
#  resp_content_type :string           default("text/plain")
#
class Webhook < ApplicationRecord
  belongs_to :account, optional: true

  has_many :backpacks

  scope :find_by_id_or_uuid, ->(id) { where("uuid = ? OR id = ?", id, id.to_i).first }

  before_create :set_init_data
  def set_init_data
    self.uuid = SecureRandom.uuid.gsub('-', '')
  end

  def request_url
    "#{ENV['WEBSITE_URL']}/r/#{uuid}"
  end

  def build_response_body(backpack)
    template = Liquid::Template.parse(resp_body)
    template.render "request" => backpack.default_template_params
  end

end
