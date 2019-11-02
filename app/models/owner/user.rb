# frozen_string_literal: true

class Owner::User < ApplicationRecord
  validates :universal_key, presence: true
  validates :name, presence: true
end
