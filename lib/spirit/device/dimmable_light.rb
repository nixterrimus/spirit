module Device
  class DimmableLight < Device::Base
    include Capability::Switchable
    include Capability::Dimmable
  end
end
