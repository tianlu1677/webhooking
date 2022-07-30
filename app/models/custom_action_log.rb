# frozen_string_literal: true

class CustomActionLog < ApplicationRecord
  belongs_to :webhook, optional: true
  belongs_to :backpack, optional: true
  belongs_to :from_custom_action, class_name: 'CustomAction', optional: true
  belongs_to :next_custom_action, class_name: 'CustomAction', optional: true

  class << self
    def log!(backpack, custom_action, original_params: {}, custom_params: {})
      CustomActionLog.create(backpack: backpack,
                             from_custom_action_id: custom_action.id,
                             original_params: original_params,
                             custom_params: custom_params)
    end
  end
end
