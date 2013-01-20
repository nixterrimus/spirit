module Device
  class ColorableLight < Device::Base
    include Capability::Switchable
    include Capability::Dimmable
    include Capability::Colorable
    include Capability::Identifiable
  end
end
