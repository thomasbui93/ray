# frozen_string_literal: true

require 'json'

module RayExceptions
  class BaseApiException < StandardError
    def to_json(*_args)
      JSON.generate(
        code: @code,
        message: @message
      )
    end

    def status
      @status || 500
    end

    def code
      @code || 'ERROR-UNKNOWN'
    end

    def message
      @message || 'An error has occurred.'
    end
  end
end
