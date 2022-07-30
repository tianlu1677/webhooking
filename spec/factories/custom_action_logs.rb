# frozen_string_literal: true

FactoryBot.define do
  factory :custom_action_log do
    webhook_id { 1 }
    from_custom_action_id { 1 }
    next_custon_action_id { 1 }
    backpack_id { 1 }
    original_params { '' }
    custom_params { '' }
  end
end
