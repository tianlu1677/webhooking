# == Schema Information
#
# Table name: custom_actions
#
#  id            :bigint           not null, primary key
#  title         :string
#  description   :string
#  custom_action :string
#  webhook_id    :bigint           not null
#  category      :string
#  sort          :integer
#  input_dict    :jsonb
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class CustomAction < ApplicationRecord
  belongs_to :webhook
  acts_as_list scope: :webhook_id
  # before_create :cal_sort

  self.inheritance_column = 'category'

  def could_used_variable_names
    keys = webhook.default_template_param_keys

    return keys if position.to_i.zero?

    added_variables = webhook.custom_actions.where("category = 'CustomAction::Variable' and position < ?", position).all.map {|x| x.input_name}


    keys + added_variables
  end

  private

  # def cal_sort
  #   if webhook.custom_actions.first.nil?
  #     self.sort = 1
  #   else
  #     self.sort ||= webhook.custom_actions.last.sort + 1
  #   end
  # end
end
