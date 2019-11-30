# frozen_string_literal: true

require 'attributes/merge'

class Owner::User::Update < BaseService
  def initialize(params)
    @user_id = params[:id]
    @user_data = params
  end

  def execute
    user = Attributes::Merge.assign_parameter(Owner::User.find(@user_id), @user_data)
    user.save!
    user
  rescue ActiveRecord::RecordNotFound => _e
    raise RayExceptions::EntityNotFound
  rescue ActiveRecord::RecordInvalid => error
    raise RayExceptions::InvalidData, error.message
  rescue StandardError => _e
    raise RayExceptions::OperationFailed, 'update'
  end
end
