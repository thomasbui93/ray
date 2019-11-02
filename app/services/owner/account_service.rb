# frozen_string_literal: true

class Owner::AccountService
  def minimum(account_id)
    Owner::Account.new do |acc|
      acc.id = account_id
    end
  end
end
