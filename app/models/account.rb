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
class Account < ApplicationRecord
  before_create :set_init_data

  has_many :webhooks
  belongs_to :user, optional: true

  def set_init_data
    self.uuid = SecureRandom.uuid.gsub('-', '')
  end
end
