# == Schema Information
#
# Table name: backpacks
#
#  id          :bigint           not null, primary key
#  uuid        :string
#  url         :string
#  req_method  :string
#  ip          :string
#  hostname    :string
#  user_agent  :string
#  referer     :string
#  content     :text
#  headers     :jsonb
#  status_code :integer
#  req_params  :jsonb
#  account_id  :integer
#  token_uuid  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Backpack < ApplicationRecord
  belongs_to :account, optional: true
  belongs_to :webhook, foreign_key: :token_uuid, optional: true

  before_create :set_init_data

  def set_init_data
    self.uuid = SecureRandom.uuid.gsub('-', '')
  end
end
