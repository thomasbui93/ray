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

  def update(id, parameters = {})
    value = Vault::Value.find(id)
    value.value = parameters[:value]
    value.save!
    value
  end

  def get_by_path(path, account_id, application_id)
    account = @account_service.minimum(account_id)
    application = @application_service.minimum(application_id)
    Vault::Value.find_by!(
      path: path,
      account: account,
      application: application
    )
  end

  def delete(id)
    Vault::Value.delete(id)
  end

  def get(id)
    Vault::Value.find(id)
  end

  def delete_by(path, account_id, application_id)
    account = @account_service.minimum(account_id)
    application = @application_service.minimum(application_id)
    Vault::Value.delete_by!(
      path: path,
      account: account,
      application: application
    )
  end
end
