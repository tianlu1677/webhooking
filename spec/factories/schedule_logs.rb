# frozen_string_literal: true

# == Schema Information
#
# Table name: schedule_logs
#
#  id               :bigint           not null, primary key
#  response_status  :integer
#  response_headers :jsonb
#  response_body    :text
#  request          :text
#  error            :text
#  schedule_id      :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
FactoryBot.define do
  factory :schedule_log do
    response_status { 1 }
    response_headers { "" }
    response_body { "MyText" }
    request { "MyText" }
    error { "MyText" }
  end
end
