# frozen_string_literal: true

# == Schema Information
#
# Table name: agents
#
#  id         :bigint           not null, primary key
#  type       :string
#  name       :string
#  webhook_id :integer
#  options    :jsonb
#  position   :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :agent do
    type { "" }
    name { "MyString" }
    webhook_id { 1 }
    option { "MyString" }
    position { 1 }
  end
end
