class Preset
  include Toy::Store
  include Toy::Store::All

  attribute :target_value, Hash
  attribute :device_ids, Array

  attribute :name, String

  def add_device(device)
    raise "Device not persisted" unless device.persisted?
    device_ids << device.id
    target_value[device.id] = filtered_attributes(device)
  end

  def devices
    device_ids.collect { |device_id| Device.read(device_id) }
  end

  def apply
    devices.each do |device|
      device.update_attributes(target_value[device.id])
    end
  end

  private

  def filtered_attributes(device)
    device.attributes.except("type", "id")
  end
end
