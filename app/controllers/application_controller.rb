# frozen_string_literal: true

require_relative '../../lib/auth'

class ApplicationController < ActionController::API
  include PaginationConcern
  include JSONAPI::Errors

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from Auth::JwtTokenExpired, with: :auth_token_expired
  rescue_from Auth::JwtTokenInvalid, with: :auth_token_invalid
  rescue_from Auth::JwtTokenMissing, with: :auth_token_missing

  private

  def authenticate
    Auth.authorize(request.headers) do |user|
      instance_variable_set(:@current_user, user)
    end
  end

  def ensure_cart_owner!
    id = params[:cart_id] || params[:id]
    cart = Cart.find id

    unless cart.send(:user)&.id.eql? current_user&.id
      raise ActiveRecord::RecordNotFound
        .new(nil, Cart, id, nil)
    end

    @cart = cart
  end

  def ensure_order_owner!
    id = params[:order_id] || params[:id]

    @order = @current_user.orders.find id
  end

  attr_reader :current_user

  def record_not_found(exception)
    render json: { message: "#{exception.model} not found" }, status: :not_found
  end

  def auth_token_missing
    render json: { message: 'authorization token required' }, status: :unauthorized
  end

  def auth_token_expired
    render json: { message: 'authorization token expired' }, status: :unauthorized
  end

  def auth_token_invalid
    render json: { message: 'authorization token invalid' }, status: :unauthorized
  end
end
