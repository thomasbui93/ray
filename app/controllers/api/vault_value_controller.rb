# frozen_string_literal: true

# api/vault_value controller
class Api::VaultValueController < ApplicationController
  def initialize
    @vault_service = Vault::VaultService.new
  end

  allow_parameters :index, %i[application_id account_id]
  def index
    items = @vault_service.fetch(params[:account_id], params[:application_id])
    render json: { items: items }, status: :ok
  end

  allow_parameters :destroy, %i[application_id account_id id]
  def destroy
    @vault_service.delete(params[:id])
  end

  allow_parameters :show, %i[application_id account_id id]
  def show
    value = @vault_service.get(params[:id])
    render json: { value: value }, status: :ok
  end

  allow_parameters :create, %i[application_id account_id value path]
  def create
    value = @vault_service.create params
    render json: { 'value': value }, status: :ok
  end

  allow_parameters :update, %i[application_id account_id value path]
  def update
    value = @vault_service.update params[:id], params
    render json: { 'value': value }, status: :ok
  end
end
