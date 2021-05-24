class CustomAction
  class Request < ::CustomAction
    store_accessor :input_dict, :url, :method, :content_type, :trigger_variable, :body, prefix: 'input'
    validates_presence_of :input_url

    def build_real_body(original_params, custom_params)
      template = Liquid::Template.parse(input_body)
      template.render({"request" => original_params}.merge(custom_params))
    rescue
      "解析语法错误"
    end

    def build_real_url(original_params, custom_params)
      template = Liquid::Template.parse(input_url)
      template.render({"request" => original_params}.merge(custom_params))
    end

    def execute(original_params, custom_params = {})
      dict = {
        url: build_real_url(original_params, custom_params),
        method: input_method,
        timeout: 5,
        payload: build_real_body(original_params, custom_params),
        headers: {
          "user-agent" => "webhook-king custom action"
        }
      }

      unless input_content_type.blank?
        dict[:headers][:content_type] = input_content_type
      end

      begin
        RestClient::Request.execute(
          dict
        )
      rescue
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
  end
end