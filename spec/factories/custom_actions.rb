# == Schema Information
#
# Table name: custom_actions
#
#  id            :bigint           not null, primary key
#  title         :string
#  description   :string
#  custom_action :string
#  webhook_id    :bigint           not null
#  category      :string
#  input_dict    :jsonb
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  position      :integer
#
FactoryBot.define do
  factory :custom_action do
    title { "MyString" }
    description { "MyString" }
    custom_action { "MyString" }
    webhook { nil }
    category { "MyString" }
    sort { 1 }
    input_dict { "" }
  end
end
