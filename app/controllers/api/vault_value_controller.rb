# frozen_string_literal: true

# api/vault_value controller
class Api::VaultValueController < ApplicationController
  def index
    render json: [], status: :ok
  end

  def create
    account = Owner::Account.new do |acc|
      acc.id = params[:account_id]
    end

    application = System::Application.new do |app|
      app.id = params[:application_id]
    end

    value = Vault::Value.new do |v|
      v.account = account
      v.application = application
      v.value = params[:value]
      v.path = params[:path]
    end

    value.save!

    render json: { 'value': value }, status: :ok
  end
end
