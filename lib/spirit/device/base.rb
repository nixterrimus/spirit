module Device
  class Base
    attr_accessor :adapter, :configuration

    def initialize(params = {})
      @adapter = params.fetch(:adapter, default_adapter)
      @configuration = params.fetch(:configuration, default_configuration)
    end

    def update_attributes(attributes = {})
      attributes.each { |key, val| send("#{key}=", val) if respond_to?("#{key}=") }
    end

    # Eventually need to be wrapped up to handle problems with talking
    #  to the real world (ie, begin resuce)
    def apply_state
      adapter.set_current_state(self)
    end

    def request_state
      adapter.get_current_state(self)
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
