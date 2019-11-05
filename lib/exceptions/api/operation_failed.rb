# frozen_string_literal: true

require_relative './base'

module RayExceptions
  class OperationFailed < BaseApiException
    def initialize(reason)
      @message = "Operation #{reason} failed!"
      @code = 'ERR-OP-FAILED'
      @status = 400
    end
  end
end
