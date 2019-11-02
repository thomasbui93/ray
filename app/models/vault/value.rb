# frozen_string_literal: true

class Vault::Value < ApplicationRecord
  validates :value, presence: true
  validates :path, presence: true

  belongs_to :account, class_name: 'Owner::Account'
  belongs_to :application, class_name: 'System::Application'
end
