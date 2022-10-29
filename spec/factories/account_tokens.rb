# frozen_string_literal: true

# == Schema Information
#
# Table name: webhooks
#
#  id            :bigint           not null, primary key
#  uuid          :string
#  receive_email :string
#  expired_at    :datetime
#  user_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :webhook do
    uuid { 'MyString' }
    receive_email { 'MyString' }
    expired_at { '2021-05-14 15:18:29' }
    user_id { 1 }
  end
end
