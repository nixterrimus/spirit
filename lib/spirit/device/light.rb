module Device
  class Light < Device::Base
    include Device::Abilities::Switchable
    include Device::Abilities::Identifiable
  end
end
