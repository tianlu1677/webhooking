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
class CustomActionLog < ApplicationRecord
  belongs_to :webhook, optional: true
  belongs_to :request, optional: true
  belongs_to :from_custom_action, class_name: 'CustomAction', optional: true
  belongs_to :next_custom_action, class_name: 'CustomAction', optional: true

  class << self
    def log!(request, custom_action, original_params: {}, custom_params: {})
      CustomActionLog.create(request:,
                             from_custom_action_id: custom_action.id,
                             original_params:,
                             custom_params:)
    end
  end
end
