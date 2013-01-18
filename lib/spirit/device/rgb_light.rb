module Device
  class RGBLight < Device::Base
    include Capability::Switchable
    include Capability::Dimmable
    #include Capability::RGBable
  end
end
