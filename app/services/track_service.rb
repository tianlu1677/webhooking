# frozen_string_literal: true

class TrackService
  attr_accessor :request, :headers

  def initialize(request, _token_uuid = '')
    @request = request
    @headers = request.headers
  end

  def do!
    headers = extract_http_request_headers(request.headers)
    find_webhook(request.params[:backpack_token])

    req_method = request.method
    ip = request.remote_ip
    hostname = request.hostname
    user_agent = request.user_agent
    referer = request.referer
    content_length = request.content_length
    status_code = 200

    query_params = request.query_parameters
    form_params = extract_form_params(request)
    content_type = request.content_type
    media_type = request.media_type
    file_params = extra_file_params(request)
    raw_content = request.raw_post
    raw_content = '' if file_params.present?
    # 当有文件时，把文件都提取出来。
    request_data = {
      headers: headers,
      req_method: req_method,
      ip: ip,
      hostname: hostname,
      user_agent: user_agent,
      referer: referer,
      status_code: status_code,
      query_params: query_params,
      form_params: form_params,
      raw_content: raw_content,
      content_type: content_type,
      content_length: content_length,
      media_type: media_type,
      user_id: @webhook.user_id
    }
    Rails.logger.info("request #{request_data}")

    backpack = @webhook.backpacks.create!(request_data)
    upload_file_params(file_params, backpack)
    # binary_upload(request, backpack)
    backpack
  end

  def extract_form_params(request)
    return {} unless %w[multipart/form-data application/x-www-form-urlencoded].include?(request.content_type)

    request.request_parameters.reject { |_k, v| v.is_a?(ActionDispatch::Http::UploadedFile) }
  end

  def upload_file_params(file_params, backpack)
    return if file_params.blank?

    file_params.each do |key, fileupload|
      backpack.files.attach(io: File.open(fileupload.tempfile),
                            filename: fileupload.original_filename,
                            content_type: fileupload.content_type,
                            metadata: { params_key: key })
    end
  end

  def binary_upload(request, backpack)
    if request.media_type.present? && request.media_type != 'multipart/form-data' && request.content_type.present? && request.content_length.positive?
      backpack.files.attach(io: StringIO.new(request.raw_post),
                            filename: 'xxxx',
                            content_type: request.content_type,
                            metadata: {
                              binary_upload: '1'
                            })
    end
  end

  def extra_file_params(request)
    request.request_parameters.select { |_k, v| v.is_a?(ActionDispatch::Http::UploadedFile) }
  end

  def find_webhook(uuid)
    @webhook = Webhook.find_by!(uuid: uuid)
  end

  def extract_http_request_headers(env)
    allow = %w[CONTENT_TYPE CONTENT_LENGTH]
    env.reject do |k, _v|
      (k != /^HTTP_[A-Z_]+$/ && !allow.include?(k)) || k == 'HTTP_VERSION'
    end.map do |k, v|
      [reconstruct_header_name(k), v]
    end.each_with_object(Rack::Utils::HeaderHash.new) do |k_v, hash|
      k, v = k_v
      hash[k] = v
    end
  end

  def reconstruct_header_name(name)
    name.sub(/^HTTP_/, '').gsub('_', '-').downcase
  end

  COOKIE_PARAM_PATTERN = %r{\A([^(),/<>@;:\\"\[\]?={}\s]+)(?:=([^;]*))?\Z}.freeze
  COOKIE_SPLIT_PATTERN = /;\s*/.freeze

  def parse_cookie(cookie_str)
    params = cookie_str.split(COOKIE_SPLIT_PATTERN)
    info = params.shift.match(COOKIE_PARAM_PATTERN)
    return {} unless info

    cookie = {
      name: info[1],
      value: CGI.unescape(info[2])
    }

    params.each do |param|
      result = param.match(COOKIE_PARAM_PATTERN)
      next unless result

      key = result[1].downcase.to_sym
      value = result[2]
      case key
      when :expires
        begin
          cookie[:expires] = Time.parse(value)
        rescue ArgumentError
        end
      when :httponly, :secure
        cookie[key] = true
      else
        cookie[key] = value
      end
    end

    cookie
  end
end
