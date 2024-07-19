# frozen_string_literal: true

class TrackService
  attr_accessor :req, :headers

  def initialize(req, _token_uuid = '')
    @req = req
    @headers = req.headers
  end

  def do!
    headers = extract_http_req_headers(req.headers)
    find_webhook(req.params[:request_token])

    req_method = req.method
    ip = req.remote_ip
    hostname = req.hostname
    user_agent = req.user_agent
    referer = req.referer
    content_length = req.content_length
    status_code = 200

    query_params = req.query_parameters
    form_params = extract_form_params(req)
    content_type = req.content_type
    media_type = req.media_type
    file_params = extra_file_params(req)
    raw_content = req.raw_post
    raw_content = '' if file_params.present?
    # 当有文件时，把文件都提取出来。
    req_data = {
      headers:,
      req_method:,
      ip:,
      hostname:,
      user_agent:,
      referer:,
      status_code:,
      query_params:,
      form_params:,
      raw_content:,
      content_type:,
      content_length:,
      media_type:,
      user_id: @webhook.user_id
    }
    Rails.logger.info("req #{req_data}")

    request = @webhook.requests.create!(req_data)
    upload_file_params(file_params, request)
    # binary_upload(req, req)
    request
  end

  def extract_form_params(req)
    return {} unless %w[multipart/form-data application/x-www-form-urlencoded].include?(req.content_type)

    req.request_parameters.reject { |_k, v| v.is_a?(ActionDispatch::Http::UploadedFile) }
  end

  def upload_file_params(file_params, request)
    return if file_params.blank?

    file_params.each do |key, fileupload|
      request.files.attach(io: File.open(fileupload.tempfile),
                           filename: fileupload.original_filename,
                           content_type: fileupload.content_type,
                           metadata: { params_key: key })
    end
  end

  # def binary_upload(request, request)
  #   if request.media_type.present? && request.media_type != 'multipart/form-data' && request.content_type.present? && request.content_length.positive?
  #     request.files.attach(io: StringIO.new(request.raw_post),
  #                           filename: 'xxxx',
  #                           content_type: request.content_type,
  #                           metadata: {
  #                             binary_upload: '1'
  #                           })
  #   end
  # end

  def extra_file_params(req)
    req.request_parameters.select { |_k, v| v.is_a?(ActionDispatch::Http::UploadedFile) }
  end

  def find_webhook(uuid)
    @webhook = Webhook.find_by!(uuid:)
  end

  def extract_http_req_headers(env)
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

  COOKIE_PARAM_PATTERN = %r{\A([^(),/<>@;:\\"\[\]?={}\s]+)(?:=([^;]*))?\Z}
  COOKIE_SPLIT_PATTERN = /;\s*/

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
