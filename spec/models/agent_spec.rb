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
require 'rails_helper'

RSpec.describe Agent, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
