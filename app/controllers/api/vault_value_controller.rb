# frozen_string_literal: true

# api/vault_value controller
class Api::VaultValueController < ApplicationController
  def initialize
    @vault_service = Vault::VaultService.new
  end

  def index
    render json: [], status: :ok
  end

  def create
    value = @vault_service.create params
    render json: { 'value': value }, status: :ok
  rescue StandardError => _e
    render json: { 'error': true }, status: :error
  end
end
