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

    def fetch_variable(from_variable, dict)
      arr = if from_variable.start_with?('request')
              from_variable.split('.')[1..-1] # 排除 Request
            else
              from_variable.split('.')
      end
      dict.dig(*arr)
    rescue StandardError
      nil
    end

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
