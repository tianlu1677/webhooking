# frozen_string_literal: true

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
  class Request < ::CustomAction
    store_accessor :input_dict, :url, :method, :content_type, :trigger_variable, :body, :trigger_condition, :response_body, :response_head_code, prefix: 'input'
    validates_presence_of :input_url

    def build_real_body(original_params, custom_params)
      template = Liquid::Template.parse(input_body)
      template.render({ 'request' => original_params }.merge(custom_params))
    rescue StandardError
      '解析语法错误'
    end

    def build_real_url(original_params, custom_params)
      template = Liquid::Template.parse(input_url)
      template.render({ 'request' => original_params }.merge(custom_params))
    end

    def execute(original_params, custom_params = {})
      if input_trigger_condition.to_s != ''
        return if fetch_variable(input_trigger_condition, original_params.merge(custom_params)).blank?
      end

      dict = {
        url: build_real_url(original_params, custom_params),
        method: input_method,
        timeout: 5,
        payload: build_real_body(original_params, custom_params),
        headers: {
          'user-agent' => 'webhook-king custom action'
        }
      }

      dict[:headers][:content_type] = input_content_type unless input_content_type.blank?

      begin
        r = RestClient::Request.execute(
          dict
        )
        fill_response_info(r, custom_params)
      rescue StandardError => e
        if e.respond_to? :response
          fill_response_info(e.response)
        else
          fill_response_info(nil, custom_params)
        end

        [original_params, custom_params]
      end
      [original_params, custom_params]
    end

    def info
      {
        url: '',
        method: '',
        content_type: '',
        body: ''
      }
    end

    def fill_response_info(r, custom_params)
      r = OpenStruct.new({ code: 0, body: 0 }) if r.nil?

      custom_params[input_response_head_code] = r.code unless input_response_head_code.blank?
      custom_params[input_response_body] = r.body unless input_response_body.blank?
    end
  end
end
