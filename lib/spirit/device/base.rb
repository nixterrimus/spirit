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

    private

    def default_adapter
      Adapter::NilAdapter.new
    end

    def default_configuration
      {}
    end
  end
end
