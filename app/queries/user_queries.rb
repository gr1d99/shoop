# frozen_string_literal: true

class UserQueries
  module Scopes
    def by_id(params = {})
      return self unless params.key?(:user_id) || params.key?(:id)

      id = params[:user_id] || params[:id]

      where(id: id)
    end

    def by_email(params = {})
      return self unless params.key?(:email)

      where(email: params[:email])
    end

    def by_phone(params = {})
      return self unless params.key?(:phone)

      where(phone: params[:phone])
    end
  end

  class << self
    def call(scope = User.all, filters = {})
      new(scope).call(filters)
    end
  end

  def initialize(scope)
    @scope = scope
  end

  def call(filters)
    User
      .extending(UserQueries::Scopes)
      .by_id(filters)
      .by_email(filters)
      .by_phone(filters)
  end
end
