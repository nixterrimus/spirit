module Device
  class Base
    attr_accessor :adapter, :configuration, :adapter_uuid
    include Device::Abilities::Identifiable
    include ::Persistance

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

    private

    def default_adapter
      Adapter::NilAdapter.new
    end

    def default_configuration
      {}
    end

  end
end
