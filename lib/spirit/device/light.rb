module Device
  class Light < Device::Base
    include Capability::Switchable
    include Capability::Identifiable
  end
end
