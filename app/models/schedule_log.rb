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
class ScheduleLog < ApplicationRecord
  belongs_to :schedule
end
