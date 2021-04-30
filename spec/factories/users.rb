# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  username           :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  email              :string
#  encrypted_password :string(128)
#  confirmation_token :string(128)
#  remember_token     :string(128)
#

FactoryBot.define do
  factory :user do
    email { "11@qq.com" }
    password { "123456 "}
  end
end
