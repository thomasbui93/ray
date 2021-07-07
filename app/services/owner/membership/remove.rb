# frozen_string_literal: true

class Owner::Membership::Remove < BaseService
  def initialize(account_id, user_id)
    @account_id = account_id
    @user_id = user_id
  end

  def execute
    membership = Owner::Membership.find(
      account_id: account_id,
      user_id: user_id
    )
    membership.destroy!
  rescue ActiveRecord::RecordNotFound => _e
    raise RayExceptions::EntityNotFound
  rescue ActiveRecord::RecordInvalid => error
    raise RayExceptions::InvalidData, error.message
  rescue StandardError => _e
    raise RayExceptions::OperationFailed, 'update'
  end
end
