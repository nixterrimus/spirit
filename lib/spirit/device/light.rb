module Device
  class Light < Device::Base
    include Capability::Switchable
  end
end
