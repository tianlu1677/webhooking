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
require 'rails_helper'

RSpec.describe Backpack, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
