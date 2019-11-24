# frozen_string_literal: true

class Owner::Membership < ApplicationRecord
  self.table_name = 'accounts_users'

  validate :validate_primary_user

  ROLES = {
    0 => 'primary',
    1 => 'staff',
    2 => 'viewer'
  }.freeze

  belongs_to :account
  belongs_to :user

  def primary?
    role.zero?
  end

  def validate_primary_user
    return unless primary? && self.class.find_by(account_id: account_id, role: 0)

    errors.add(:role, 'Account could only has one primary user.')
  end
end
