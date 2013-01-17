module Adapter
  class NilAdapter

    def set_state(params = {})
      nil
    end

    def get_state(device = nil)
      {}
    end
  end
end
