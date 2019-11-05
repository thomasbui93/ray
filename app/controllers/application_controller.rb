# frozen_string_literal: true

require 'exceptions/api/base'

class ApplicationController < ActionController::Base
  rescue_from RayExceptions::BaseApiException,
              with: :render_error_response

  private

  def render_error_response(error)
    render json: error.to_json, status: error.status
  end
end
