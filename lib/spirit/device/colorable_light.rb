class Device::ColorableLight < Device::Base
  include Device::Abilities::Switchable
  include Device::Abilities::Dimmable
  include Device::Abilities::Colorable
end

