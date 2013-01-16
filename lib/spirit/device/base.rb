module Device
  class Base
    attr_accessor :adapter, :configuration

    def initialize(params = {})
      @adapter = params.fetch(:adapter, default_adapter)
      @configuration = params.fetch(:configuration, default_configuration)
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
