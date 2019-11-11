# frozen_string_literal: true

require 'exceptions/api/entity_not_found'
require 'exceptions/api/operation_failed'
require 'exceptions/api/invalid_data'

class Vault::VaultService
  def initialize
    @account_service = Owner::AccountService.new
    @application_service = System::ApplicationService.new
  end

  def fetch(account_id, application_id)
    account = @account_service.minimum(account_id)
    application = @application_service.minimum(application_id)
    Vault::Value.where(
      account: account,
      application: application,
      parent_id: nil
    ).limit(40)
  rescue ActiveRecord::RecordNotFound => _e
    raise RayExceptions::EntityNotFound
  end

  def create(parameters = {})
    account = @account_service.minimum(parameters[:account_id])
    application = @application_service.minimum(parameters[:application_id])
    value = Vault::Value.new do |v|
      v.account = account
      v.application = application
      v.value = parameters[:value]
      v.path = parameters[:path]
      v.parent_id = parameters[:parent_id]
    end
    value.save!
    value
  rescue ActiveRecord::RecordInvalid => e
    raise RayExceptions::InvalidData, e.message
  rescue StandardError => _e
    raise RayExceptions::OperationFailed, 'create'
  end

  def update(id, parameters = {})
    value = Vault::Value.find(id)
    value.value = parameters[:value]
    value.save!
    value
  rescue ActiveRecord::RecordNotFound => _e
    raise RayExceptions::EntityNotFound
  rescue ActiveRecord::RecordInvalid => e
    raise RayExceptions::InvalidData, e.message
  rescue StandardError => _e
    raise RayExceptions::OperationFailed, 'update'
  end

  def delete(id)
    effected = Vault::Value.delete(id)
    raise RayExceptions::OperationFailed, 'deletion' unless effected == 1
  end

  def get(id)
    Vault::Value.find(id)
  rescue ActiveRecord::RecordNotFound => _e
    raise RayExceptions::EntityNotFound
  end

  def get_parent(id)
    value = Vault::Value.find(id)
    value.parent_id ? Vault::Value.find(value.parent_id) : nil
  rescue ActiveRecord::RecordNotFound => _e
    raise RayExceptions::EntityNotFound
  end

  def get_children(id)
    Vault::Value.children(id)
  rescue ActiveRecord::RecordNotFound => _e
    raise RayExceptions::EntityNotFound
  end
end
