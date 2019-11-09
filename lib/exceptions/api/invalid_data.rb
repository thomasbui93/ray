# frozen_string_literal: true

require_relative './base'

module RayExceptions
  class InvalidData < BaseApiException
    def initialize(message)
      @message = message
      @code = 'ERR-INVALID-DATA'
      @status = 400
    end
  end
end
