# frozen_string_literal: true

class Vault::VaultService
  def initialize
    @account_service = Owner::AccountService.new
    @application_service = System::ApplicationService.new
  end

  def create(parameters = {})
    account = @account_service.minimum(parameters[:account_id])
    application = @application_service.minimum(parameters[:application_id])
    value = Vault::Value.new do |v|
      v.account = account
      v.application = application
      v.value = parameters[:value]
      v.path = parameters[:path]
    end
    value.save!
    value
  end
end
