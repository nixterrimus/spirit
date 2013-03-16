module Spirit
  class IntentListener
    attr_reader :spirit
    def initialize(spirit, config={})
      @spirit = spirit
    end

    def listen
      sleep
    end
  end
end
