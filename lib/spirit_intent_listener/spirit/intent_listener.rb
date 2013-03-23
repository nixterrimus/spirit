module Spirit
  class IntentListener
    attr_reader :spirit
    def initialize(spirit, config={})
      @spirit = spirit
    end

    def listen
      redis.psubscribe(channel_to_listen_on) do |c|
        c.pmessage { |ptrn, channel, message| intent_received(channel, message) }
      end
    end

    def intent_received(intent_identifier, params)
      logger.info "Intent: #{intent_identifier} | params: #{params}"
      intent_for(intent_identifier).apply(parse_params(params))
    rescue
      logger.error "Failed to apply #{intent_identifier}"
    end


    private

    def channel_to_listen_on
      'intents.spirit.*'
    end

    def redis
      @redis ||= Redis.new
    end

    # This might be better as a factory
    def intent_for(channel)
      root_intent_class = channel.split(".").last.classify
      klass = Object.const_get("Intent").const_get(root_intent_class)
      klass.new
    end

    # Too much happening in this class, this belong elsewhere
    def parse_params(params)
      JSON.parse(params).with_indifferent_access
    end

    def logger
      @logger ||= Logger.new(STDOUT)
    end

  end
end
