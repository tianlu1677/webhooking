# == Schema Information
#
# Table name: account_tokens
#
#  id            :bigint           not null, primary key
#  uuid          :string
#  receive_email :string
#  expired_at    :datetime
#  account_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :account_token do
    uuid { "MyString" }
    receive_email { "MyString" }
    expired_at { "2021-05-14 15:18:29" }
    account_id { 1 }
  end
end
