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
  include RailsSortable::Model
  set_sortable :sort
  belongs_to :webhook

  self.inheritance_column = 'category'

  def could_used_variable_names
    keys = webhook.default_template_param_keys

    return keys if sort.to_i.zero?

    added_variables = webhook.custom_actions.where("category = 'CustomAction::Variable' and sort < ?", sort).all.map {|x| x.input_name}


    keys + added_variables
  end
end
