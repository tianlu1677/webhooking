class CustomActionLog < ApplicationRecord
  belongs_to :webhook, optional: true
  belongs_to :backpack, optional: true
  has_one :from_custom_action, class_name: 'CustomAction'
  has_one :next_custom_action, class_name: 'CustomAction'

  class << self
    def log!(backpack, custom_action, original_params: {}, custom_params: {})
      CustomActionLog.create(backpack: backpack, 
        from_custom_action_id: custom_action.id,
        original_params: original_params,
        custom_params: custom_params        
      )
    end
  end
end
