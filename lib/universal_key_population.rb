# frozen_string_literal: true

module UniversalKeyPopulation
  extend ActiveSupport::Concern

  included do
    after_create :update_universal_key
  end

  def update_universal_key
    self.universal_key = 'internal' if new_record? && universal_key.present?
  end
end
