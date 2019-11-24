# frozen_string_literal: true

require 'universal_key_population'

class Owner::User < ApplicationRecord
  include UniversalKeyPopulation

  if universal_key == 'internal'
    validates :email,
              uniqueness: true,
              format: { with: URI::MailTo::EMAIL_REGEXP }
  end

  if universal_key == 'internal'
    validates :password,
              length: { minimum: 6 }
  end

  validates :universal_key, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :memberships, inverse_of: :user, dependent: :destroy
  has_many :accounts, through: :memberships
end
