class Preset
  include Toy::Store
  include Toy::Store::All

  attribute :target_value, Hash
  attribute :device_ids, Array

  def add_device(device)
    raise "Device not persisted" unless device.persisted?
    device_ids << device.id
    target_value[device.id] = filtered_attributes(device)
  end

  def devices
    Device.read(device_ids)
  end

  private

  def filtered_attributes(device)
    device.attributes.except("type", "id")
  end
end
