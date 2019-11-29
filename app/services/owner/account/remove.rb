# frozen_string_literal: true

class Owner::Account::Remove < BaseService
  def initialize(account_id)
    @account_id = account_id
  end

  def execute
    account = Owner::Account.find(@account_id)
    raise ArgumentError, 'Account not found with given id' unless account

    Owner::Account.transaction do
      users = account.users
      account.destroy!
      users.each { |user| Owner::User::Cleanse.call(user) }
    end
  end
end
