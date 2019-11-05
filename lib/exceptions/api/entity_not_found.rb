# frozen_string_literal: true

require_relative './base'

module RayExceptions
  class EntityNotFound < BaseApiException
    def initialize
      @message = 'Not record matched given query.'
      @code = 'ERR-NOT-FOUND'
      @status = 404
    end
  end
end
