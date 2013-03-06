class PresetEvents < ActiveModel::Observer
  observe :preset

  def after_apply(preset)
    EventBus.fire_event("preset.applied", { id: preset.id })
  end

end

# After this file is loaded, immediately load the observer so
# that is begins to observe. An instance on the observer must
# exist before models can be observed.
PresetEvents.instance
