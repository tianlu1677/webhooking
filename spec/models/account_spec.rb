# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id         :bigint           not null, primary key
#  user_id    :integer          not null
#  uuid       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'create user' do
    it 'can create account has uuid' do
      user = FactoryBot.create(:user)
      account = user.account

      expect(account.uuid).not_to be_empty
    end
  end
end
