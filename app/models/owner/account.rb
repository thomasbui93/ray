# frozen_string_literal: true

require 'universal_key_population'

class Owner::Account < ApplicationRecord
  include UniversalKeyPopulation

  validates :universal_key, presence: true
  validates :name, presence: true

  has_many :configuration_values, dependent: :destroy
  has_many :users, through: :memberships
  has_many :memberships, inverse_of: :account, dependent: :destroy
end
