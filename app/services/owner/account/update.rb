# frozen_string_literal: true

require 'attributes/merge'

class Owner::Account::Update < BaseService
  def initialize(params)
    @account_id = params[:id]
    @account_data = params
  end

  def execute
    account = Attributes::Merge.assign_parameter(Owner::Account.find(@account_id), @account_data)
    account.save!
    account
  rescue ActiveRecord::RecordNotFound => _e
    raise RayExceptions::EntityNotFound
  rescue ActiveRecord::RecordInvalid => error
    raise RayExceptions::InvalidData, error.message
  rescue StandardError => _e
    raise RayExceptions::OperationFailed, 'update'
  end
end
