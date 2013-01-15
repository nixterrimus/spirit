module Device
  class Base
    attr_accessor :adapter

    def initialize(adapter)
      @adapter = adapter
    end
  end
end
