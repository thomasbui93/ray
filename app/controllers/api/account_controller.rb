# frozen_string_literal: true

# api/account controller
class Api::AccountController < ApplicationController
  allow_parameters :*, :anything
  allow_parameters :create, :anything

  def create
    account = Owner::Account::Create.call(params)

    render json: { account: account }, status: :ok
  end

  allow_parameters :show, %i[id]
  def show
    account = Owner::Account::Get.call(params[:id])
    render json: { account: account }, status: :ok
  end

  allow_parameters :update, :anything
  def update
    account = Owner::Account::Update.call(params)
    render json: { account: account }, status: :ok
  end

  allow_parameters :destroy, %i[id]
  def destroy
    Owner::Account::Remove.call(params[:id])
    render json: { done: true }, status: :ok
  end
end
