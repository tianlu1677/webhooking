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
require 'rails_helper'

RSpec.describe ScheduleLog, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
