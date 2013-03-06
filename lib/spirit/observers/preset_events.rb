class PresetEvents < ActiveModel::Observer
  observe :preset

  def after_apply(preset)
    notify_message_bus("preset.#{preset.id}.applied")
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
PresetEvents.instance
