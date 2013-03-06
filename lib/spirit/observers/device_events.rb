class DeviceEvents < ActiveModel::Observer
  observe(Device.descendants.push(Device) )

  def after_update(device)
    notify_message_bus("device.#{device.id}.updated")
  end

  private

  def notify_message_bus(channel, message={})
    full_channel = "zap.event.#{channel}"
    puts "#{full_channel}: #{message}"
  end
end

# After this file is loaded, immediately load the observer so
# that is begins to observe. An instance on the observer must
# exist before models can be observed.
DeviceEvents.instance
