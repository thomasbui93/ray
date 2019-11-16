# frozen_string_literal: true

module Attributes
  module ChangeSet
    def self.get_change_set(changes)
      changes.map { |key, value| [key, value[1]] }.to_h
    end
  end
end
