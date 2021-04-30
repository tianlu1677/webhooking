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

require 'rails_helper'

RSpec.describe User, type: :model do
  describe "create user" do
    it 'ok' do
      user = create(:user)
      expect(user.id).to eq 1
    end 
  end  
end
