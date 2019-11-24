# frozen_string_literal: true

class Owner::AccountService
  class_attribute :user_service, default: Owner::UserService.new

  def register(account_detail:, primary_user:)
    account = Owner::Account.new(account_detail)
    user = user_service.fetch_or_create(primary_user)

    Owner::Account.transaction do
      account.save!
      user.save!
      account.memberships.create!(account_id: account.id, user_id: user.id, role: 0)
    end

    [account, user]
  end

  def add_membership(account_id, user_id, role)
    Owner::Membership.create!(account_id: account_id, user_id: user_id, role: role)
  end

  def remove(account_id)
    account = Owner::Account.find(account_id)
    raise ArgumentError, 'Account not found with given id' unless account

    Owner::Account.transaction do
      users = account.users
      account.destroy!
      user_service.clean_up(users)
    end
  end
end
