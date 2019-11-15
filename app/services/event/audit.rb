# frozen_string_literal: true

class Event::Audit
  attr_accessor :audit_service

  def initialize(entity_type)
    @audit_service = Event::AuditService.new(entity_type)
  end

  def audit_create_event(entity)
    @audit_service.create_audit(entity.id, 'create', entity)
  end

  def audit_update_event(id, payload)
    @audit_service.create_audit(id, 'create', get_change_set(payload))
  end

  def audit_remove_event(id)
    @audit_service.create_audit(id, 'remove', {})
  end

  def get_change_set(changes)
    changes.map { |k, v| [k, v[1]] }.to_h
  end
end
