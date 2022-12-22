# frozen_string_literal: true

class UserSerializer
  include JSONAPI::Serializer

  attributes :email, :phone, :first_name, :last_name
end
