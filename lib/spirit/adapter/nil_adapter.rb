module Adapter
  class NilAdapter

    def set_current_state(params = {})
      nil
    end

    def current_state(device = nil)
      device.update_attributes({}) if device
    end
  end
end
