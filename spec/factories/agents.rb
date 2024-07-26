FactoryBot.define do
  factory :agent do
    type { "" }
    name { "MyString" }
    webhook_id { 1 }
    option { "MyString" }
    position { 1 }
  end
end
