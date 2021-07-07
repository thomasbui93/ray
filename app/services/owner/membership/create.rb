# frozen_string_literal: true

class Owner::Membership::Create < BaseService
  def initialize(account_id, user_id, role)
    @account_id = account_id
    @user_id = user_id
    @role = role
  end

  def execute
    Owner::Membership.create!(account_id, user_id, role)
  rescue ActiveRecord::RecordInvalid => error
    raise RayExceptions::InvalidData, error.message
  rescue StandardError => _e
    raise RayExceptions::OperationFailed, 'create'
  end
end
