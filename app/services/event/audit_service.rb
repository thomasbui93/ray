# frozen_string_literal: true

class Event::AuditService
  attr_accessor :entity_type

  def initialize(entity_type)
    @entity_type = entity_type
  end

  def create_audit(id, type, payload)
    audit = Events::Audit.new do |a|
      a.payload = payload
      a.entity_type = @entity_type
      a.entity_id = id
      a.audit_type = type
    end
    audit.save!
  end

  def get_events(entity_id)
    raise ArgumentError, 'Invalid event entity_id: nil' if entity_id.blank?

    Events::Audit.for_enity(@entity_type).where('entity_id', entity_id) if entity_id.present?
  end
end
