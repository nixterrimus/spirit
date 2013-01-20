module Device
  class DimmableLight < Device::Base
    include Capability::Switchable
    include Capability::Dimmable
    include Capability::Identifiable
  end
end
