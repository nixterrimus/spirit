class PresetEvents < ActiveModel::Observer
  observe :preset

  def after_apply(preset)
    EventBus.fire_event("preset.applied", json_for_preset(preset) )
  end

  def json_for_preset(preset)
    PresetSerializer.new(preset).to_json
  end

end

# After this file is loaded, immediately load the observer so
# that is begins to observe. An instance on the observer must
# exist before models can be observed.
PresetEvents.instance
