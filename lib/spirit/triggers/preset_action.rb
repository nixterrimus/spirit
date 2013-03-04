class PresetAction < Action

  attribute :preset_id, String

  def apply
    preset.apply
  end

  def preset
    Preset.find(preset_id)
  end
end
