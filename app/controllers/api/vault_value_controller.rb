# frozen_string_literal: true

# api/vault_value controller
class Api::VaultValueController < ApplicationController
  def initialize
    @vault_service = Vault::VaultService.new
  end

  def index
    items = @vault_service.fetch(params[:account_id], params[:application_id])
    render json: { items: items }, status: :ok
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
  end

  def update
    value = @vault_service.update params[:id], params
    render json: { 'value': value }, status: :ok
  end
end
