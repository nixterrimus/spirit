module Toy
  module Store
    module Celluloid
      extend ActiveSupport::Concern

      module ClassMethods
        def load(id, attrs)
          attrs ||= {}
          instance = constant_from_attrs(attrs).allocate
          instance.initialize_from_database(attrs.update('id' => id))
          instance.nil? ? nil : ::Celluloid::Actor.new(instance).proxy
        end
      end
    end
  end
end
