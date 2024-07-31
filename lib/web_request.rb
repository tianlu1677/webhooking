# frozen_string_literal: true

class WebRequest
  attr_accessor :request_dict

  def initialize(request_method:, request_url:, request_headers: {}, timeout: 30, request_body: {})
    @request_dict = build_request_dict(request_method:, request_url:, request_headers:, timeout:, request_body:)
  end

  def execute
    response = ::RestClient::Request.execute(request_dict)

    {
      status: true,
      response_body: response.body,
      response_headers: response.headers,
      response_status: response.code,
      request: request_dict.to_json
    }
  rescue RestClient::Exception => e
    {
      status: false,
      request: request_dict.to_json,
      error_message: e.message
    }
  rescue StandardError => e
    {
      status: false,
      error_message: "#{e.class}: #{e.message}"
    }
  end

  def build_request_dict(request_method:, request_url:, request_headers:, timeout:, request_body:)
    {
      method: request_method,
      url: request_url,
      payload: request_body,
      headers: request_headers,
      timeout:
    }
  end
end
