# frozen_string_literal: true

require 'attributes/merge'

class Owner::Account::Update < BaseService
  def initialize(params)
    @account_id = params[:id]
    @account_data = params
  end

  def execute
    account = Attributes::Merge.assign_parameter(Owner::Account.find(@account_id), @account_data)
    account.save!
    account
  end
end
