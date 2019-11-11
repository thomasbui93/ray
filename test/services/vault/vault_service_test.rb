# frozen_string_literal: true

require 'test_helper'

class Vault::VaultServiceTest < ActiveSupport::TestCase
  fixtures 'owner/accounts', 'system/applications'

  def setup
    @subject = Vault::VaultService.new
  end

  test 'create method: sufficent data' do
    account = owner_accounts(:minimum_account)
    application = system_applications(:minimum_app)
    assert @subject.create(
      account_id: account.id,
      application_id: application.id,
      value: 'value',
      path: 'path'
    )
  end

  test 'create method: insufficent data' do
    account = owner_accounts(:minimum_account)
    application = system_applications(:minimum_app)
    assert_raises(RayExceptions::InvalidData) do
      @subject.create(
        account_id: account.id,
        value: 'value',
        path: 'path'
      )
    end

    assert_raises(RayExceptions::InvalidData) do
      @subject.create(
        application_id: application.id,
        value: 'value',
        path: 'path'
      )
    end
  end

  test 'create method: invalid relational data' do
    assert_raises(RayExceptions::OperationFailed) do
      @subject.create(
        account_id: -1,
        application_id: -2,
        value: 'value',
        path: 'path'
      )
    end
  end

  test 'update method: entity not found data' do
    assert_raises(RayExceptions::EntityNotFound) do
      @subject.update(
        -1,
        value: 'xyz'
      )
    end
  end

  test 'update method: invalid data' do
    value = vault_values(:minimum_vault_parent)
    assert_raises(RayExceptions::InvalidData) do
      @subject.update(
        value.id,
        value: nil
      )
    end
  end

  test 'update method: valid data' do
    value = vault_values(:minimum_vault)
    value.account = owner_accounts(:minimum_account)
    value.save!
    assert @subject.update(
      value.id,
      value: 'another valid value'
    )
  end

  test 'delete method: invalid data' do
    assert_raises(RayExceptions::OperationFailed) do
      @subject.delete('wrongid')
    end
  end

  test 'delete method: valid data' do
    value = vault_values(:minimum_vault)
    assert_nothing_raised do
      @subject.delete(value.id)
    end
  end

  test 'get method: valid id' do
    value = vault_values(:minimum_vault)
    assert @subject.get(value.id)
  end

  test 'get method: invalid id' do
    assert_raises(RayExceptions::EntityNotFound) do
      @subject.get(-1)
    end
  end

  test 'get_parent method: parentless record' do
    value = vault_values(:minimum_vault)
    assert_not @subject.get_parent(value.id)
  end

  test 'get_parent method: parent record' do
    value = vault_values(:minimum_vault)
    value.account = owner_accounts(:minimum_account)
    value.parent_id = vault_values(:minimum_vault_child).id
    value.save!
    assert @subject.get_parent(value.id)
  end

  test 'get_children method: parent record' do
    value = vault_values(:minimum_vault_parent)
    assert @subject.get_children(value.id)
  end
end
