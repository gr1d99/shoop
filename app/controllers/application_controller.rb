class ApplicationController < ActionController::API
  include JSONAPI::Errors

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def authenticate
    authenticate_with_http_token do |token, options|
      p "token = #{token}"

      # Compare the tokens in a time-constant manner, to mitigate
      # timing attacks.
      ActiveSupport::SecurityUtils.secure_compare(token, 'aa')
    end
  end

  private

  def record_not_found(exception)
    render json: { message: exception.message }, status: :not_found
  end
end
