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
#
FactoryBot.define do
  factory :backpack do
    uuid { "MyString" }
    url { "MyString" }
    method { "MyString" }
    ip { "MyString" }
    hostname { "MyString" }
    user_agent { "MyString" }
    referer { "MyString" }
    content { "MyString" }
    headers { "MyString" }
  end
end
