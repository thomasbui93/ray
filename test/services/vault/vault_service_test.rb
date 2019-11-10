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
end
