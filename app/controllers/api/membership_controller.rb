# frozen_string_literal: true

# api/membership controller
class Api::MembershipController < ApplicationController
  def destroy
    Owner::Account::Create.call(params[:account_id], params[:user_id], 1)
    render json: { done: true }, status: :ok
  end

  def create
    Owner::Account::Remove.call(params[:id], params[:user_id])
    render json: { done: true }, status: :ok
  end
end
