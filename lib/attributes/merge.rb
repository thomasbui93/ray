# frozen_string_literal: true

module Attributes
  module Merge
    def self.assign_parameter(target, parameter)
      target
        .assign_attributes(parameter
          .permit(*target.attributes.keys)
          .permit!
          .to_h)
      target
    end
  end
end
