class Devices
  include ::Poolable

  def initialize
    add(Device::Light.new)
    add(Device::DimmableLight.new)
    add(Device::ColorableLight.new)
    add(Device::Light.new)
  end


end
