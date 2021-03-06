# frozen_string_literal: true

class Events::Audit < ApplicationRecord
  ALLOWED_ENTITY_TYPES = %w[vault_value owner_account system_application].freeze
  ALLOWED_TYPES = %w[create update delete].freeze
  before_save :trim_payload
  validate :validate_entity_type

  def readonly?
    !new_record?
  end

  scope :for_entity, lambda { |type|
    where(entity_type: type) if type.present?
  }

  def trim_payload
    trim_method = "trim_payload_#{entity_type}".to_sym
    send(trim_method) if respond_to? trim_method
  end

  def trim_payload_vault_value
    self.payload = {
      account_id: payload['account_id'],
      application_id: payload['application_id'],
      value: payload['value'],
      path: payload['path'],
      parent_id: payload['parent_id']
    }.compact
  end

  def trim_payload_owner_account
    self.payload = {
      universal_key: payload['universal_key']
    }
  end

  def trim_payload_system_application
    self.payload = {
      universal_key: payload['universal_key']
    }
  end

  def validate_entity_type
    errors.add :entity_type, 'Invalid entity_type' unless entity_type.in? ALLOWED_ENTITY_TYPES
  end

  def validate_type
    errors.add :audit_type, 'Invalid type' unless audit_type.in? ALLOWED_TYPES
  end
end
