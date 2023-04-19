# frozen_string_literal: true

class BaseService
  attr_reader :params, :kwargs
  attr_accessor :result

  def initialize(params, kwargs)
    @params = params
    @kwargs = kwargs
    @result = OpenStruct.new(success: nil)
  end

  def self.call(params = {}, **kwargs)
    new(params, kwargs).call
  end
end
