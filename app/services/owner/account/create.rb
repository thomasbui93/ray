# frozen_string_literal: true

require 'attributes/merge'

class Owner::Account::Create < BaseService
  def initialize(account_detail)
    @account_detail = account_detail
    @user_id = account_detail[:user_id]
  end

  def execute
    account = Attributes::Merge.assign_parameter(Owner::Account.new, @account_detail)

    Owner::Account.transaction do
      account.save!
      account.memberships.create!(account_id: account.id, user_id: @user_id, role: 0)
    end

    account
  end
end
