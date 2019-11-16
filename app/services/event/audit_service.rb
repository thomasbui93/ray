# frozen_string_literal: true

require 'attributes/change_set'

class Event::AuditService
  attr_reader :entity_type

  def initialize(entity_type)
    @entity_type = entity_type
  end

  def audit_create_event(entity)
    create_audit(entity.id, 'create', entity)
  end

  def audit_update_event(id, payload)
    create_audit(id, 'update', Attributes::ChangeSet.get_change_set(payload))
  end

  def audit_remove_event(id)
    create_audit(id, 'remove', {})
  end

  def create_audit(id, type, payload)
    audit = Events::Audit.new(
      payload: payload,
      entity_type: @entity_type,
      entity_id: id,
      audit_type: type
    )
    audit.save!
    audit
  end

  def get_events(entity_id)
    Events::Audit.for_entity(@entity_type).where(entity_id: entity_id) if entity_id.present?
  end
end
