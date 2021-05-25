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
#  input_dict    :jsonb
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  position      :integer
#
class CustomAction
  class Variable < ::CustomAction
    store_accessor :input_dict, :from_variable, :name, :category, :filter_val, prefix: 'input'
    validates_presence_of :input_name

    def items
      [:from_variable, :name, :category, :filter_val].map(&:to_s)
    end

    def execute(original_params, custom_params = {})
      @original_params = original_params
      @custom_params = custom_params

      old_variable = fetch_variable(input_dict['from_variable'], original_params.merge(custom_params))
      return [original_params, custom_params] if old_variable.nil? && input_category != 'render'

      new_variable_val = calc_new_variable_answer(old_variable, input_dict["category"], input_dict["filter_val"])

      custom_params[input_dict['name']] = new_variable_val.to_s
      [original_params, custom_params]
    end

    private



    def calc_new_variable_answer(variable, category, filter_val)
      case category
      when 'jsonpath'
        path = JsonPath.new(filter_val)
        path.on(variable)&.first
      when 'regex'
        re = Regexp.new(filter_val)
        if x = variable.match(re)
          x[0]
        end
      when 'render'
        template = Liquid::Template.parse(filter_val)
        template.render({"request" => @original_params}.merge(@custom_params))
      end
    end
  end
end
