# frozen_string_literal: true

require 'json'

module RayExceptions
  class BaseApiException < StandardError
    def initialize(
      message = 'An error has occurred.',
      code = 'ERROR-UNKNOWN',
      status = 500
    )
      @message = message
      @code = code
      @status = status
    end

    def to_json(*_args)
      JSON.generate(
        code: @code,
        message: @message
      )
    end
  end
end
