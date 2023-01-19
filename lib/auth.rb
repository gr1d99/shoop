# frozen_string_literal: true

module Auth
  class Error < StandardError; end
  class JwtTokenExpired < Error; end
  class JwtTokenInvalid < Error; end
  class JwtTokenMissing < Error; end

  class << self
    def authorize(headers, identity_klass = User, identity_field = :email, &block)
      token = jwt_token(headers)

      raise JwtTokenMissing if token.nil?

      decoded = ::JWT.decode(token, Rails.application.secrets.secret_key_base, true)
      payload = HashWithIndifferentAccess.new decoded[0]
      identity = payload[:identity]
      query_h = { identity_field.to_s => identity }
      user = identity_klass.find_by!(query_h)
      block.call user if block_given?
    rescue ::JWT::ExpiredSignature
      raise JwtTokenExpired
    rescue ::JWT::DecodeError, ActiveRecord::RecordNotFound
      raise JwtTokenInvalid
    end

    private

    def authorization_header(headers)
      headers.fetch('Authorization', nil)
    end

    def jwt_token(headers)
      authorization_header(headers)&.split(' ')&.[](1)
    end
  end
end
