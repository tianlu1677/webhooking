class TrackService
  attr_accessor :request, :headers

  def initialize(request, token_uuid = '')
    @request = request
    @headers = request.headers
  end

  def do!
    headers = extract_http_request_headers(request.headers)
    find_account_token(request.params[:backpack_token])

    req_method = request.method
    ip = request.remote_ip
    hostname = request.hostname
    user_agent = request.user_agent
    referer = request.referer
    content = request.content_length
    status_code = 200
    req_params = request.params.reject { |x| %w[controller action backpack_token].include?(x) }

    request_data = {
      headers: headers,
      req_method: req_method,
      ip: ip,
      hostname: hostname,
      user_agent: user_agent,
      referer: referer,
      status_code: status_code,
      req_params: req_params,
      content: content,
      account_id: @account_token.account_id
    }
    Rails.logger.info("request #{request_data}")

    backpack = @account_token.backpacks.create!(request_data)
  end

  def find_account_token(uuid)
    @account_token = AccountToken.find_by!(uuid: uuid)
  end

  def extract_http_request_headers(env)
    env.reject do |k, v|
      !(/^HTTP_[A-Z_]+$/ === k) || k == 'HTTP_VERSION' || v.nil? || k == 'HTTP_COOKIE'
    end.map do |k, v|
      [reconstruct_header_name(k), v]
    end.each_with_object(Rack::Utils::HeaderHash.new) do |k_v, hash|
      k, v = k_v
      hash[k] = v
    end
  end

  def reconstruct_header_name(name)
    name.sub(/^HTTP_/, '').gsub('_', '-')
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