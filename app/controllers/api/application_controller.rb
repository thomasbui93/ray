# frozen_string_literal: true

# api/application controller
class Api::ApplicationController < ApplicationController
  allow_parameters :*, :anything

  allow_parameters :create, :anything
  def create
    application = System::Application.new do |app|
      app.name = params[:name]
      app.universal_key = params[:universal_key]
    end
    application.save!

    render json: { application: application }, status: :ok
  end
end
