class Devices
  attr_accessor :device_pool

  def initialize

  end

  def self.all
    [ Device::Light.new, Device::DimmableLight.new, Device::ColorableLight.new]
  end
end
