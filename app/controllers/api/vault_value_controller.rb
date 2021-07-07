# frozen_string_literal: true

# api/vault_value controller
class Api::VaultValueController < ApplicationController
  allow_parameters :*, %i[application_id account_id]

  def initialize
    @vault_service = Vault::VaultService.new
  end

  allow_parameters :index, %i[]
  def index
    items = @vault_service.fetch(params[:account_id], params[:application_id])
    render json: { items: items }, status: :ok
  end

  allow_parameters :destroy, %i[id]
  def destroy
    @vault_service.delete(params[:id])
    render json: { done: true }, status: :ok
  end

  allow_parameters :show, %i[id]
  def show
    value = @vault_service.get(params[:id])
    render json: { value: value }, status: :ok
  end

  allow_parameters :create, %i[value path parent_id]
  def create
    value = @vault_service.create params
    render json: { 'value': value }, status: :ok
  end

  allow_parameters :update, %i[value path parent_id id]
  def update
    value = @vault_service.update params[:id], params
    render json: { 'value': value }, status: :ok
  end

  allow_parameters :parent, %i[id]
  def parent
    parent = @vault_service.get_parent params[:id]
    render json: { 'parent': parent }, status: :ok
  end

  allow_parameters :children, %i[id]
  def children
    children = @vault_service.get_children params[:id]
    render json: { 'children': children }, status: :ok
  end

  allow_parameters :audits, %i[id]
  def audits
    audits = @vault_service.get_audits params[:id]
    render json: { 'audits': audits }, status: :ok
  end
end
