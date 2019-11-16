# frozen_string_literal: true

require 'test_helper'

class Events::AuditTest < ActiveSupport::TestCase
  fixtures 'events/audits'
  test 'vault payload valid' do
    audit = Events::Audit.new
    audit.entity_type = 'vault_value'
    audit.entity_id = 1
    audit.payload = {
      path: 'test_path',
      value: 'test_value',
      application_id: 1,
      account_id: 1
    }
    audit.audit_type = 'create'
    assert audit.save!
    assert audit.entity_type, 'vault_value'
    assert audit.entity_id, 1
    assert audit.payload,
           path: 'test_path',
           value: 'test_value',
           application_id: 1,
           account_id: 1
  end

  test 'vault payload invalid' do
    audit = Events::Audit.new
    audit.entity_type = 'vault_value'
    audit.entity_id = 1
    audit.payload = {
      path: 'test_path',
      value: 'test_value',
      application_id: 1,
      account_id: 1,
      test1: 1,
      test2: 2
    }
    audit.audit_type = 'create'
    assert audit.save!
    assert audit.payload,
           path: 'test_path',
           value: 'test_value',
           application_id: 1,
           account_id: 1
  end

  test 'vault entity_type invalid' do
    audit = Events::Audit.new
    audit.entity_type = 'vault'
    audit.entity_id = 1
    audit.payload = {
      path: 'test_path',
      value: 'test_value',
      application_id: 1,
      account_id: 1,
      test1: 1,
      test2: 2
    }
    audit.audit_type = 'create'
    assert_raises(ActiveRecord::RecordInvalid) do
      audit.save!
    end
  end

  test 'not allow modify' do
    audit = events_audits(:vault_created_audit)
    audit.entity_type = 'owner_account'
    assert_raises(ActiveRecord::ReadOnlyRecord) do
      assert_not audit.save!
    end
  end

  test 'not allow remove' do
    audit = events_audits(:vault_created_audit)
    assert_raises(ActiveRecord::ReadOnlyRecord) do
      assert_not audit.destroy!
    end
  end

  test 'for_entity scope' do
    audits = Events::Audit.for_entity(:vault_value).all
    assert audits.size, 2
  end
end
