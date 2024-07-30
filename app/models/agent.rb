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
class Agent < ApplicationRecord
  belongs_to :webhook

  acts_as_list scope: :webhook_id

  def execute
    raise NotImplementedError, "Subclasses must implement the execute method"
  end
end
