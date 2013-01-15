module Capability
  module BinaryDevice

    @binary_state = :off

    def binary_state
      @binary_state
    end

    def binary_state=(state)
      @binary_state = state
    end

    def on
      self.binary_state = :on
    end

    def off
      self.binary_state = :off
    end

    def on?
      self.binary_state == :on
    end

    def off?
      self.binary_state == :off
    end

    def toggle
      self.on? ? self.off : self.on
    end
  end
end
