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
class Schedule < ApplicationRecord
  has_many :schedule_logs, dependent: :destroy
end
