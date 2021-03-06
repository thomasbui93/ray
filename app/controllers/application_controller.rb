# frozen_string_literal: true

require 'exceptions/api/base'
require 'guard/parameters'

class ApplicationController < ActionController::Base
  include RayGuard::Parameters

  rescue_from StandardError, with: :render_standard_error
  rescue_from RayExceptions::BaseApiException, with: :render_error_response

  private

  def render_standard_error(error)
    Rails.logger.debug "Message: #{error.message}, backtrace: #{error.backtrace}"
    render json: { error: 'Internal Error.' }, status: :error
  end

  def render_error_response(error)
    render json: error.to_json, status: error.status
  end
end
