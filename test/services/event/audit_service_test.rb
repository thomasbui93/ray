# frozen_string_literal: true

require 'test_helper'

class Event::AuditServiceTest < ActiveSupport::TestCase
  fixtures 'events/audits', 'vault/values'

  def setup
    @subject = Event::AuditService.new('vault_value')
  end

  test 'audit_create_event method: sufficent vault values' do
    audit = @subject.audit_create_event(vault_values(:minimum_vault))
    assert audit
    assert audit.audit_type, 'create'
    assert audit.entity_type, 'vault_value'
    assert audit.entity_id, 1
    assert audit.payload,
           path: 'minimum_vault_path',
           value: 'minimum_vault_value',
           application_id: 1,
           account_id: 1
  end

  test 'audit_update_event method: sufficent vault values' do
    vault = vault_values(:minimum_vault)
    audit = @subject.audit_update_event(vault.id, 'value' => %w[org changed])
    assert audit
    assert audit.audit_type, 'update'
    assert audit.entity_type, 'vault_value'
    assert audit.entity_id, vault.id
    assert audit.payload, value: 'changed'
  end

  test 'audit_remove_event method: sufficent vault values' do
    vault = vault_values(:minimum_vault)
    audit = @subject.audit_remove_event(vault.id)
    assert audit
    assert audit.audit_type, 'delete'
    assert audit.entity_type, 'vault_value'
    assert audit.entity_id, vault.id
    assert audit.payload, {}
  end

  test 'get_events method' do
    vault = vault_values(:minimum_vault)
    audits = @subject.get_events(vault.id)
    assert audits.size, 3
  end
end
