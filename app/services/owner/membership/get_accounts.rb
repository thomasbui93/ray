# frozen_string_literal: true

class Owner::Membership::GetAccounts < BaseService
  def initialize(user_id)
    @user_id = user_id
  end

  def execute
    user = Owner::User.find(@user_id)
    user.accounts
  end
end
