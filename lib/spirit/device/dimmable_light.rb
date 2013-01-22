class Device::DimmableLight < Device::Base
  include Device::Abilities::Switchable
  include Device::Abilities::Identifiable
  include Device::Abilities::Dimmable    
end
