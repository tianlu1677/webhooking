# frozen_string_literal: true

class TrackService
  attr_accessor :req, :webhook

  class << self
    def execute(webhook, req)
      new(webhook, req).execute
    end    
  end

  def initialize(webhook, req)
    @webhook = webhook
    @req = req
  end

  def request_info
    headers = extract_http_req_headers(req.headers.to_h)
    req_method = req.method
    ip = req.remote_ip
    hostname = req.hostname
    user_agent = req.user_agent
    referer = req.referer
    content_length = req.content_length
    path = "#{req.host}#{req.path}"

    status_code = 200

    query_params = req.query_parameters
    form_params = extract_form_params(req)
    content_type = req.content_type
    media_type = req.media_type
    file_params = extra_file_params(req)
    raw_content = req.raw_post
    raw_content = '' if file_params.present?
    # 当有文件时，把文件都提取出来。
    {
      path:,
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
      user_id: webhook.user_id
    }
  end

  def execute
    req_data = request_info
    Rails.logger.info("req #{req_data}")

    request = webhook.requests.create!(req_data)
    # upload_file_params(file_params, request)
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

  def extract_http_req_headers(request_headers)
    not_allowed = %(HTTP_COOKIE)
    allow_headers = request_headers.select do |k, _v|
      (k =~ /^HTTP.+$/) && !not_allowed.include?(k)
    end
    allow_headers.transform_keys do |k|
      reconstruct_header_name(k)
    end
  end

  def reconstruct_header_name(name)
    name.sub(/^HTTP_/, '').gsub('_', '-').downcase
  end
end
