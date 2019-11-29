# frozen_string_literal: true

class Owner::Account::AddMember < BaseService
  def initialize(account_id, user_id, role)
    @account_id = account_id
    @user_id = user_id
    @role = role
  end

  def execute
    Owner::Membership.create!(account_id: @account_id, user_id: @user_id, role: @role)
  end
end
