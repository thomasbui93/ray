# frozen_string_literal: true

class Owner::Account < ApplicationRecord
  validates :universal_key, presence: true
  validates :name, presence: true

  has_many :configuration_values, dependent: :destroy
end
