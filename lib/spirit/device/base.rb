module Device
  class Base
    attr_accessor :adapter

    def initialize(params = {})
      @adapter = params.fetch(:adapter, default_adapter)
    end

    private

    def default_adapter
      Adapter::NilAdapter.new
    end
  end
end
