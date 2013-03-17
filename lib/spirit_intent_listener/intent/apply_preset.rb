module Intent
  class ApplyPreset
    def apply(params)
      preset = preset_for(params)
      preset.apply
    end

    private

    def preset_for(params)
      Preset.read(preset_id_for(params))
    end

    def preset_id_for(params)
      params.fetch(:preset).fetch(:id)
    end
  end
end
