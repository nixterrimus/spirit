module Adapter
  class NilAdapter

    def set_current_state(params = {})
      # update the world to looks like what's passed in params
      nil
    end

    def current_state(device = nil)
      device.update_attributes({}) if device
    end
  end
end
