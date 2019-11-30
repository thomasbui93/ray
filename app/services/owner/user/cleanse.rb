# frozen_string_literal: true

class Owner::User::Cleanse < BaseService
  def initialize(user)
    @user = user
  end

  def execute
    @user.destroy! if @user.memberships.empty?
  rescue ActiveRecord::RecordNotFound => _e
    raise RayExceptions::EntityNotFound
  rescue ActiveRecord::RecordInvalid => error
    raise RayExceptions::InvalidData, error.message
  rescue StandardError => _e
    raise RayExceptions::OperationFailed, 'cleanse'
  end
end
