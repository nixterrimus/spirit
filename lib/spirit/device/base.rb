module Device
  class Base
    attr_accessor :adapter, :configuration, :adapter_uuid
    include ::Identifiable
    include ::Persistable::Member

    def initialize(params = {})
      @adapter = params.fetch(:adapter, default_adapter)
      @configuration = params.fetch(:configuration, default_configuration)
    end

    # Eventually need to be wrapped up to handle problems with talking
    #  to the real world (ie, begin resuce).  Don't want to assume that
    #  they are always going to work
    def apply_state
      adapter.apply_device_state(self)
    end

    def get_updated_state
      adapter.update_device_state(self)
    end

    def persistance_key
      uuid
    end

    def to_hash
      {
        uuid: uuid,
        adapter_uuid: adapter.uuid
      }
    end

    def after_load
      #@adapter = persistance_store.load(adapter_uuid)
    end

    def adapter
      @adapter || default_adapter
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

    def default_adapter
      Adapter::NilAdapter.new
    end

    def default_configuration
      {}
    end

  end
end
