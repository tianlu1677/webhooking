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
module Agents
  class Redirect < Agent
    store_accessor :options, :redirect_url, prefix: 'opt'

    validates :opt_redirect_url, presence: true

    def execute; end
  end
end
