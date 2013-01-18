module Device
  class RGBLight < Device::Base
    include Capability::Switchable
    include Capability::Dimmable
    include Capability::Colorable
  end
end
