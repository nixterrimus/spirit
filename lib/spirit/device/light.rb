module Device
  class Light < Device::Base
    include Device::Abilities::Switchable
  end
end
