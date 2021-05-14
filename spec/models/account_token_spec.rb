# == Schema Information
#
# Table name: account_tokens
#
#  id            :bigint           not null, primary key
#  uuid          :string
#  receive_email :string
#  expired_at    :datetime
#  account_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'rails_helper'

RSpec.describe AccountToken, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
