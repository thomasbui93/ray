# frozen_string_literal: true

# api/user controller
class Api::UserController < ApplicationController
  allow_parameters :*, :anything

  allow_parameters :create, :anything
  def create
    user = Owner::User::Create.call(params)

    render json: { user: user }, status: :ok
  end

  allow_parameters :show, %i[id]
  def show
    user = Owner::User::Get.call(params[:id])
    render json: { user: user }, status: :ok
  end

  allow_parameters :update, :anything
  def update
    user = Owner::User::Update.call(params)
    render json: { user: user }, status: :ok
  end

  allow_parameters :destroy, %i[id]
  def destroy
    Owner::User::Remove.call(params[:id])
    render json: { done: true }, status: :ok
  end
end
