module RayGuard
  module Parameters
    def self.included(klass)
      klass.extend(ClassMethods)
      klass.before_action :check_parameters
    end

    module ClassMethods
      def self.extended(base)
        base.class_eval do
          class_attribute :allowed_parameters
        end
      end

      def allow_parameters(action, allowed)
        allowed_parameters[action] = allowed
      end
    end
  
    private
    def check_parameters
      Rails.logger.info "Check parameters #{params[:account]}: #{allowed_parameters}"
    end
  end
end