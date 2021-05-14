# == Schema Information
#
# Table name: operation_logs
#
#  id         :bigint           not null, primary key
#  user_id    :string
#  params     :string
#  action     :string
#  controller :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class OperationLog < ApplicationRecord
end
