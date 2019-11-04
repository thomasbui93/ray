# frozen_string_literal: true

class Vault::Value < ApplicationRecord
  validates :value, presence: true
  validates :path, presence: true, uniqueness: {
    scope: %i[account_id application_id],
    message: 'Configuration is existed'
  }
  attr_readonly :account_id, :path

  belongs_to :account, class_name: 'Owner::Account'
  belongs_to :application, class_name: 'System::Application'
end
