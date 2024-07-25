# frozen_string_literal: true

class HttpUtils
  COOKIE_PARAM_PATTERN = %r{\A([^(),/<>@;:\\"\[\]?={}\s]+)(?:=([^;]*))?\Z}
  COOKIE_SPLIT_PATTERN = /;\s*/

  class << self
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
          rescue ArgumentError => e
            puts "Invalid expires value: #{value}, #{e.message}"
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
end
