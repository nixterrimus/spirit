module Device
  class Base
    #attr_accessor :adapter, :configuration, :adapter_uuid
    include Toy::Store

    reference :device_adapter, Adapter::Base

    #def initialize(params = {})
      #@adapter = params.fetch(:adapter, default_adapter)
      #@configuration = params.fetch(:configuration, default_configuration)
    #end

    # Eventually need to be wrapped up to handle problems with talking
    #  to the real world (ie, begin resuce).  Don't want to assume that
    #  they are always going to work
    def apply_state
      adapter.apply_device_state(self)
    end

    def get_updated_state
      adapter.update_device_state(self)
    end

    def abilities
      ability_modules.collect { |m| ability_module_to_s(m) }
    end

    def update_attributes!(attributes)
      update_attributes(attributes)
      apply_state
    end

    private

    def ability_modules
      self.class.included_modules.select { |m| ability_module?(m) }
    end

    def ability_module?(m)
      m.to_s =~ /Abilities/
    end

    def ability_module_to_s(m)
      m.to_s.downcase.split('::').last
    end
  end
end
