# frozen_string_literal: true

# == Schema Information
#
# Table name: requests
#
#  id             :bigint           not null, primary key
#  uuid           :string
#  webhook_uuid   :string
#  url            :string
#  req_method     :string
#  size           :integer
#  time           :float
#  ip             :string
#  note           :string
#  hostname       :string
#  user_agent     :string
#  referer        :string
#  headers        :jsonb
#  status_code    :integer
#  user_id        :integer
#  webhook_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  content_length :integer          default(0)
#  query_params   :jsonb
#  form_params    :jsonb
#  content_type   :string
#  media_type     :string
#  raw_content    :text
#  path           :string
#
require 'rails_helper'

RSpec.describe Request, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
