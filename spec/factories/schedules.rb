# frozen_string_literal: true

# == Schema Information
#
# Table name: schedules
#
#  id                 :bigint           not null, primary key
#  name               :string
#  interval           :string
#  request_url        :string
#  request_method     :string
#  request_body       :text
#  request_headers    :jsonb
#  request_status_min :string
#  request_status_max :string
#  user_id            :integer
#  cron               :string
#  last_run_at        :datetime
#  last_run_status    :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
FactoryBot.define do
  factory :schedule do
    name { "MyString" }
    interval { "MyString" }
    request_url { "MyString" }
    request_method { "MyString" }
    request_body { "MyString" }
    request_headers { "MyString" }
    request_body { "MyString" }
    request_status_min { "MyString" }
    request_status_max { "MyString" }
    user_id { 1 }
    cron { "MyString" }
    last_run_at { "MyString" }
    last_run_status { "MyString" }
  end
end
