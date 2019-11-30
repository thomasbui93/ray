# frozen_string_literal: true

class Owner::User::Remove < BaseService
  def initialize(user_id)
    @user_id = user_id
  end

  def execute
    user = Owner::User.find(@user_id)
    user.destroy!
  rescue ActiveRecord::RecordNotFound => _e
    raise RayExceptions::EntityNotFound
  rescue ActiveRecord::RecordInvalid => error
    raise RayExceptions::InvalidData, error.message
  rescue StandardError => _e
    raise RayExceptions::OperationFailed, 'delete'
  end
end
