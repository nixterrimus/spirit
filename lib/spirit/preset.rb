class Preset
  include ::Identifiable

  def add_device(device)
    device_target_attributes[device.uuid] = device.ephemeral_attribute_values
  end

  def device_uuids
    device_target_attributes.keys
  end

  private

  def device_target_attributes
    @devices ||= Hash.new
  end
end
