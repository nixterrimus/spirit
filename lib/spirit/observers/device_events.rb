class DeviceEvents < ActiveModel::Observer
  observe(Device.descendants.push(Device) )

  def after_update(device)
    EventBus.fire_event("device.#{device.id}.updated")
  end

end

# After this file is loaded, immediately load the observer so
# that is begins to observe. An instance on the observer must
# exist before models can be observed.
DeviceEvents.instance
