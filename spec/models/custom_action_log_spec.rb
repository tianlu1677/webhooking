# frozen_string_literal: true

# == Schema Information
#
# Table name: custom_action_logs
#
#  id                    :bigint           not null, primary key
#  webhook_id            :integer
#  from_custom_action_id :integer
#  next_custom_action_id :integer
#  request_id            :integer
#  original_params       :jsonb
#  custom_params         :jsonb
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
require 'rails_helper'

RSpec.describe CustomActionLog, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
