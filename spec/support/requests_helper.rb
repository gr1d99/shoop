# frozen_string_literal: true

module RequestsHelper
  def authorization_header(identity = nil)
    user = create(:user) if identity.nil?
    secret = Rails.application.secrets.secret_key_base
    payload = { identity: identity || user.email }
    jwt_token = JWT.encode payload, secret, 'HS256'

    { Authorization: "Bearer #{jwt_token}" }
  end
end

RSpec.configure do |config|
  config.include RequestsHelper, type: :request
end
