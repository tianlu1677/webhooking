# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  email              :string           not null
#  encrypted_password :string(128)      not null
#  confirmation_token :string(128)
#  remember_token     :string(128)      not null
#  is_admin           :boolean          default(FALSE)
#

FactoryBot.define do
  factory :user do
    email { "11@qq.com" }
    password { "123456 "}
  end
end
