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
require 'rails_helper'

RSpec.describe Backpack, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
