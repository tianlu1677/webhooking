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
FactoryBot.define do
  factory :custom_action_log do
    webhook_id { 1 }
    from_custom_action_id { 1 }
    next_custon_action_id { 1 }
    request_id { 1 }
    original_params { '' }
    custom_params { '' }
  end
end
