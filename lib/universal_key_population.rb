# frozen_string_literal: true

module UniversalKeyPopulation
  def self.included(klass)
    klass.before_validation :update_universal_key
  end

  def update_universal_key
    self.universal_key = 'internal' if new_record? && universal_key.blank?
  end
end
