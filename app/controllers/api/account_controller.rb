# frozen_string_literal: true

# api/account controller
class Api::AccountController < ApplicationController
  allow_parameters :*, :anything

  allow_parameters :create, :anything
  def create
    account = Owner::Account.new do |acc|
      acc.id = params[:account_id]
      acc.name = params[:name]
      acc.universal_key = params[:universal_key]
    end
    account.save!

    render json: { account: account }, status: :ok
  end
end
