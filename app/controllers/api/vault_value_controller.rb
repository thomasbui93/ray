# frozen_string_literal: true

# api/vault_value controller
class Api::VaultValueController < ApplicationController
  def initialize
    @vault_service = Vault::VaultService.new
  end

  def index
    render json: [], status: :ok
  end

  def destroy
    @vault_service.delete(params[:id])
  end

  def show
    @vault_service.get(params[:id])
  end

  def create
    value = @vault_service.create params
    render json: { 'value': value }, status: :ok
  rescue StandardError => e
    render json: { 'error': e.message }, status: :error
  end

  def update
    value = @vault_service.update params[:id], params
    render json: { 'value': value }, status: :ok
  rescue StandardError => e
    render json: { 'error': e.message }, status: :error
  end
end
