module Intent
  class UpdateDevice
    def apply(params)
      device = device_for(params)
      device.update_attributes(state_for(params))
    end

    private

    def device_for(params)
      id = params.fetch(:device).fetch(:id)
      Device.read(id)
    end

    def state_for(params)
      params.fetch(:state)
    end
  end
end
