# frozen_string_literal: true

class Vault::Value < ApplicationRecord
  scope :children, lambda { |parent_id|
    where(parent_id: parent_id) if parent_id.present?
  }

  validates :value, presence: true
  validates :path, presence: true, uniqueness: {
    scope: %i[account_id application_id parent_id],
    message: 'Configuration is existed'
  }
  validates :account_id, presence: true
  validates :application_id, presence: true

  attr_readonly :account

  belongs_to :parent,
             class_name: 'Vault::Value',
             foreign_key: 'parent_id',
             optional: true,
             inverse_of: 'value'

  belongs_to :account, class_name: 'Owner::Account'
  belongs_to :application, class_name: 'System::Application'
end
