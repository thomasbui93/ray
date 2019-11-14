# frozen_string_literal: true

class Event::AuditService
  attr_accessor :entity_type

  def initialize(entity_type)
    @entity_type = entity_type
  end

  def create_audit(id, payload)
    Events::Audit.new do |audit|
      audit.payload = payload
      audit.entity_type = @entity_type
      audit.entity_id = id
    end
  end

  def get_events(entity_id)
    raise ArgumentError.new('Invalid event entity_id: nil') unless entity_id.present?
    Events::Audit.for_enity(@entity_type).where('entity_id', entity_id) if entity_id.present?
  end

  def extract_payload(payload); end
end
