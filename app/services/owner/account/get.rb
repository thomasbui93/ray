# frozen_string_literal: true

class Owner::Account::Get < BaseService
  def initialize(account_id)
    @account_id = account_id
  end

  def execute
    account = Owner::Account.find(@account_id)
    account
  end
end
