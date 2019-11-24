# frozen_string_literal: true

# api/account controller
class Api::AccountController < ApplicationController
  allow_parameters :*, :anything
  allow_parameters :create, :anything

  def initialize
    @account_service = Owner::AccountService.new
  end

  def create
    account_detail = {
      name: params[:account_name]
    }
    user_detail = {
      first_name: params[:user_first_name],
      last_name: params[:user_last_name]
    }
    account, user = @account_service.register(account_detail: account_detail, primary_user: user_detail)

    render json: { account: account, user: user }, status: :ok
  end
end
