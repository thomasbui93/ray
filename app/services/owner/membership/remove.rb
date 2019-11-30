# frozen_string_literal: true

class Owner::Membership::Remove < BaseService
  def initialize(account_id, user_id)
    @account_id = account_id
    @user_id = user_id
  end

  def execute
    membership = Owner::Membership.find(
      account_id: account_id,
      user_id: user_id
    )
    membership.destroy!
  end
end
