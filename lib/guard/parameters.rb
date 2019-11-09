# frozen_string_literal: true

module RayGuard
  module Parameters
    ACTION_PARAMS = %w[controller action].freeze

    def self.included(klass)
      klass.extend(ClassMethods)
      klass.before_action :check_parameters
    end

    module ClassMethods
      def self.extended(base)
        base.class_eval do
          class_attribute :allowed_parameters, default: {}
        end
      end

      def allow_parameters(action, allowed)
        allowed_parameters[action] = allowed
      end
    end

    private

    def check_parameters
      whitelist_parameters = allowed_parameters[params[:action].to_sym]
      return true if whitelist_parameters == :anything

      params.each do |key, _value|
        next if ACTION_PARAMS.include? key

        params.delete(key) unless whitelist_parameters.include? key
      end
    end
  end
end
