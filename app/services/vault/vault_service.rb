# frozen_string_literal: true

require 'exceptions/api/entity_not_found'
require 'exceptions/api/operation_failed'
require 'exceptions/api/invalid_data'
require 'attributes/merge'

class Vault::VaultService
  class_attribute :audit_service, default: Event::AuditService.new('vault_value')

  extend Forwardable
  def_delegator :audit_service, :get_events, :get_audits

  def fetch(account_id, application_id)
    Vault::Value.where(
      account_id: account_id,
      application_id: application_id,
      parent_id: nil
    ).limit(40)
  rescue ActiveRecord::RecordNotFound => _e
    raise RayExceptions::EntityNotFound
  end

  def create(parameters = {})
    value = Attributes::Merge.assign_parameter(Vault::Value.new, parameters)
    ActiveRecord::Base.transaction do
      value.save!
      audit_service.audit_create_event(value)
    end
    value
  rescue ActiveRecord::RecordInvalid => error
    raise RayExceptions::InvalidData, error.message
  rescue StandardError => _e
    raise RayExceptions::OperationFailed, 'create'
  end

  def update(id, parameters = {})
    value = Attributes::Merge.assign_parameter(Vault::Value.find(id), parameters)
    ActiveRecord::Base.transaction do
      audit_service.audit_update_event(id, value.changes)
      value.save!
    end
  rescue ActiveRecord::RecordNotFound => _e
    raise RayExceptions::EntityNotFound
  rescue ActiveRecord::RecordInvalid => error
    raise RayExceptions::InvalidData, error.message
  rescue StandardError => _e
    raise RayExceptions::OperationFailed, 'update'
  end

  def delete(id)
    effected = 0
    ActiveRecord::Base.transaction do
      effected = Vault::Value.delete(id)
      audit_service.audit_remove_event(id)
    end
    raise RayExceptions::OperationFailed, 'deletion' unless effected == 1
  end

  def get(id)
    Vault::Value.find(id)
  rescue ActiveRecord::RecordNotFound => _e
    raise RayExceptions::EntityNotFound
  end

  def get_parent(id)
    value = Vault::Value.find(id)
    parent_id = value.parent_id
    Vault::Value.find(parent_id) if parent_id
  rescue ActiveRecord::RecordNotFound => _e
    raise RayExceptions::EntityNotFound
  end

  def get_children(id)
    Vault::Value.children(id)
  rescue ActiveRecord::RecordNotFound => _e
    raise RayExceptions::EntityNotFound
  end
end
