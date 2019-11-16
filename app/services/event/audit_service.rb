# frozen_string_literal: true

class Event::AuditService
  attr_accessor :entity_type

  def initialize(entity_type)
    @entity_type = entity_type
  end

  def audit_create_event(entity)
    create_audit(entity.id, 'create', entity)
  end

  def audit_update_event(id, payload)
    create_audit(id, 'update', get_change_set(payload))
  end

  def audit_remove_event(id)
    create_audit(id, 'remove', {})
  end

  def get_change_set(changes)
    changes.map { |k, v| [k, v[1]] }.to_h
  end

  def create_audit(id, type, payload)
    audit = Events::Audit.new do |aud|
      aud.payload = payload
      aud.entity_type = @entity_type
      aud.entity_id = id
      aud.audit_type = type
    end
    audit.save!
    audit
  end

  def get_events(entity_id)
    Events::Audit.for_entity(@entity_type).where(entity_id: entity_id) if entity_id.present?
  end
end
